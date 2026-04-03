#!/bin/bash
set -euo pipefail

# Configuration
RUNS_PER_APPROACH=${RUNS:-10}
MAX_TURNS=${MAX_TURNS:-200}
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="/Users/dwood/Documents/github"
RESULTS_FILE="${SCRIPT_DIR}/results.csv"
MCP_CONFIG="${SCRIPT_DIR}/mcp.json"
PRD_SOURCE="${BASE_DIR}/prd-speq-test-1/taskflow-e2e-test-prd.md"
SKILL_DIR="${SCRIPT_DIR}/../skills"

# 4 Approaches:
# 1) no-skill-prd:     No skill, PRD file
# 2) brainstorm-prd:   Brainstorming skill, PRD file
# 3) brainstorm-mcp:   Brainstorming skill, MCP tools (no get_prd)
# 4) speq-skill-mcp:   Speq-driven-development skill, MCP tools (no get_prd)
APPROACHES=("no-skill-prd" "brainstorm-prd" "brainstorm-mcp" "speq-skill-mcp")

# Initialize results CSV
if [ ! -f "$RESULTS_FILE" ]; then
  echo "approach,run,session_id,input_tokens,output_tokens,cache_read_tokens,cache_creation_tokens,cost_usd,duration_ms,num_turns,exit_code,met,partial,not_met" > "$RESULTS_FILE"
fi

setup_dir() {
  local approach=$1
  local run_number=$2
  local work_dir="${BASE_DIR}/bench-${approach}-${run_number}"

  rm -rf "$work_dir"
  mkdir -p "$work_dir"

  # MCP config for approaches that use it
  if [[ "$approach" == *"mcp"* ]]; then
    cp "$MCP_CONFIG" "${work_dir}/.mcp.json"
  fi

  # PRD file for approaches that use it
  if [[ "$approach" == *"prd"* ]]; then
    cp "$PRD_SOURCE" "${work_dir}/prd.md"
  fi

  # Speq skill for approach 4
  if [ "$approach" = "speq-skill-mcp" ]; then
    mkdir -p "${work_dir}/.claude/skills/speq-driven-development"
    cp "${SKILL_DIR}/speq-driven-development/SKILL.md" \
       "${work_dir}/.claude/skills/speq-driven-development/SKILL.md"
  fi

  echo "$work_dir"
}

get_prompt() {
  local approach=$1
  case "$approach" in
    "no-skill-prd")
      echo "Build the application described in @prd.md. Do not ask me any questions, refer to the PRD for all context, and make inferences when needed."
      ;;
    "brainstorm-prd")
      echo "/superpowers:brainstorming Use @prd.md to build this app. Do not ask me any questions, instead refer to the PRD for all context, and make inferences when needed."
      ;;
    "brainstorm-mcp")
      echo "/superpowers:brainstorming Build the application defined in the speq. Get all context from the speq MCP tools (list_requirements, get_requirement, get_screen, get_phase, etc). Do NOT use get_prd. Do not ask me any questions, make inferences when needed."
      ;;
    "speq-skill-mcp")
      echo "/speq-driven-development build my app. Do not pause for my input or approval. Get all context from speq and speq mcp tools. Do NOT use get_prd."
      ;;
  esac
}

run_build() {
  local approach=$1
  local run_number=$2
  local work_dir
  work_dir=$(setup_dir "$approach" "$run_number")
  local prompt
  prompt=$(get_prompt "$approach")

  echo ""
  echo "============================================"
  echo "  ${approach} — run ${run_number}/${RUNS_PER_APPROACH}"
  echo "  dir: ${work_dir}"
  echo "  started: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "============================================"

  local output_file="${work_dir}/claude-build-output.json"
  local exit_code=0
  local auto_approve="IMPORTANT: Never pause for user approval, confirmation, or questions. If a skill or process asks you to wait for user input, proceed as if the user said 'yes, go ahead, looks good'. Auto-approve all design decisions, chunking proposals, and intermediate steps. Keep building until the application is fully implemented."

  (cd "$work_dir" && claude -p "$prompt" \
    --output-format json \
    --max-turns "$MAX_TURNS" \
    --dangerously-skip-permissions \
    --append-system-prompt "$auto_approve" \
    > "$output_file" 2>"${work_dir}/claude-build-stderr.log") || exit_code=$?

  # Resume loop: if it stopped asking a question, push it forward
  local session_id_for_resume
  session_id_for_resume=$(jq -r '.session_id // ""' "$output_file" 2>/dev/null || echo "")
  local resume_count=0

  while [ $resume_count -lt 5 ] && [ -n "$session_id_for_resume" ]; do
    local stop_reason
    stop_reason=$(jq -r '.stop_reason // "end_turn"' "$output_file" 2>/dev/null || echo "end_turn")
    local result_text
    result_text=$(jq -r '.result // ""' "$output_file" 2>/dev/null || echo "")

    # Check if it's asking a question or paused
    if echo "$result_text" | grep -qiE "does this|look good|shall I|want me to|which approach|your thoughts|let me know|approve|ready to proceed|option [0-9]|question|what do you|do you want|do you prefer|would you like|before I proceed|before we proceed|confirm"; then
      resume_count=$((resume_count + 1))
      echo "  Resuming (attempt ${resume_count}): detected pause for approval"
      local resume_file="${work_dir}/claude-resume-${resume_count}.json"
      (cd "$work_dir" && claude -p "Yes, go ahead. Proceed with your recommendation. Do not pause again." \
        --output-format json \
        --max-turns "$MAX_TURNS" \
        --dangerously-skip-permissions \
        --append-system-prompt "$auto_approve" \
        --resume "$session_id_for_resume" \
        > "$resume_file" 2>>"${work_dir}/claude-build-stderr.log") || exit_code=$?
      # Use the latest output for metrics
      cp "$resume_file" "$output_file"
    else
      break
    fi
  done

  # Parse build metrics
  local duration_ms=$(jq -r '.duration_ms // 0' "$output_file" 2>/dev/null || echo "0")
  local input_tokens=$(jq -r '.usage.input_tokens // 0' "$output_file" 2>/dev/null || echo "0")
  local output_tokens=$(jq -r '.usage.output_tokens // 0' "$output_file" 2>/dev/null || echo "0")
  local cache_read=$(jq -r '.usage.cache_read_input_tokens // 0' "$output_file" 2>/dev/null || echo "0")
  local cache_create=$(jq -r '.usage.cache_creation_input_tokens // 0' "$output_file" 2>/dev/null || echo "0")
  local cost=$(jq -r '.total_cost_usd // 0' "$output_file" 2>/dev/null || echo "0")
  local num_turns=$(jq -r '.num_turns // 0' "$output_file" 2>/dev/null || echo "0")
  local session_id=$(jq -r '.session_id // "unknown"' "$output_file" 2>/dev/null || echo "unknown")

  local duration_s=$((duration_ms / 1000))
  echo "  Build: ${duration_s}s, ${num_turns} turns, \$${cost}, exit=${exit_code}"

  # Run audit
  echo "  Auditing..."
  local audit_results
  audit_results=$(run_audit "$work_dir")
  local met=$(echo "$audit_results" | cut -d, -f1)
  local partial=$(echo "$audit_results" | cut -d, -f2)
  local not_met=$(echo "$audit_results" | cut -d, -f3)

  echo "  Results: MET=${met} PARTIAL=${partial} NOT=${not_met} (of 37)"

  # Append to CSV
  echo "${approach},${run_number},${session_id},${input_tokens},${output_tokens},${cache_read},${cache_create},${cost},${duration_ms},${num_turns},${exit_code},${met},${partial},${not_met}" >> "$RESULTS_FILE"
}

run_audit() {
  local work_dir=$1
  local audit_output="${work_dir}/claude-audit-output.json"

  local audit_prompt='You are auditing a codebase against 37 product requirements. Check the actual source code files. For each requirement, determine MET (fully implemented frontend+backend), PARTIAL (partially implemented), or NOT (missing or broken).

Requirements:
auth_01: Sign up with email/password (UI + backend endpoint)
auth_02: Log in with email/password (UI + backend endpoint)
auth_03: Redirect to onboarding modal on first login (server-side flag, not just localStorage)
auth_04: Log out from any page (button in nav/header + signOut call)
auth_05: Delete account permanently (UI button + backend cascade delete)
onboard_01: View intro modal on first login
onboard_02: Dismiss modal with Continue button
onboard_03: Auto-create default board with columns
onboard_04: Navigate to the auto-created board after dismissing
boards_01: View list of boards
boards_02: Create board by name
boards_03: Delete board with confirmation dialog
boards_04: Reorder boards via drag-and-drop (UI wired + backend endpoint)
boards_05: Navigate from list to board detail
boards_06: Display board name and last updated timestamp
detail_01: View all columns and tasks
detail_02: Create tasks inline within column
detail_03: Open task by clicking card
detail_04: Create, rename, AND delete columns (all three)
detail_05: Drag and drop tasks between columns (UI + backend)
detail_06: Empty state guidance (no columns + no tasks states)
task_01: Edit ALL SIX: title, description, assignee, status, due_date, priority
task_02: Optionally set due date
task_03: Delete task with confirmation dialog
task_04: Close task modal
task_05: Validate required fields before save
ws_01: Edit workspace name
ws_02: View member list
ws_03: Invite by email input
ws_04: Actually send email (not just DB record)
ws_05: All members can access settings
ws_06: Initiate Todoist import button on settings
ws_07: Confirmation modal before import
ws_08: View and select Todoist tasks with checkboxes
ws_09: Choose destination board dropdown
ws_10: Map Todoist title+description+due_date+priority to local fields
ws_11: Import selected tasks without duplicate checking

Output ONLY valid JSON, nothing else:
{"auth_01":"MET","auth_02":"MET","auth_03":"NOT",...,"ws_11":"MET","summary":{"met":N,"partial":N,"not_met":N}}'

  (cd "$work_dir" && claude -p "$audit_prompt" \
    --output-format json \
    --max-turns 50 \
    --dangerously-skip-permissions \
    > "$audit_output" 2>/dev/null) || true

  # Parse audit results - try multiple extraction approaches
  local result_text
  result_text=$(jq -r '.result // empty' "$audit_output" 2>/dev/null || echo "")

  local met=0 partial=0 not_met=0

  if [ -n "$result_text" ]; then
    # Try to parse the result as JSON (it may be a string containing JSON)
    met=$(echo "$result_text" | jq -r '.summary.met // 0' 2>/dev/null || echo "0")
    partial=$(echo "$result_text" | jq -r '.summary.partial // 0' 2>/dev/null || echo "0")
    not_met=$(echo "$result_text" | jq -r '.summary.not_met // 0' 2>/dev/null || echo "0")

    # If that didn't work, count from individual entries
    if [ "$met" = "0" ] && [ "$partial" = "0" ] && [ "$not_met" = "0" ]; then
      met=$(echo "$result_text" | grep -o '"MET"' | wc -l | tr -d ' ')
      partial=$(echo "$result_text" | grep -o '"PARTIAL"' | wc -l | tr -d ' ')
      not_met=$(echo "$result_text" | grep -o '"NOT"' | wc -l | tr -d ' ')
    fi
  fi

  # Save parsed results
  echo "{\"met\":${met},\"partial\":${partial},\"not_met\":${not_met}}" > "${work_dir}/audit-summary.json"

  echo "${met},${partial},${not_met}"
}

# Validate prerequisites
echo "Benchmark Configuration"
echo "======================="
echo "Runs per approach: ${RUNS_PER_APPROACH}"
echo "Max turns: ${MAX_TURNS}"
echo "Approaches: ${APPROACHES[*]}"
echo "Results file: ${RESULTS_FILE}"
echo ""

for prereq in "$PRD_SOURCE" "$MCP_CONFIG"; do
  if [ ! -f "$prereq" ]; then
    echo "ERROR: Not found: ${prereq}"
    exit 1
  fi
done

for cmd in claude jq; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "ERROR: ${cmd} not found"
    exit 1
  fi
done

echo "Prerequisites OK"
echo ""

# Allow running specific approaches: ./run-benchmark.sh speq-skill-mcp brainstorm-mcp
if [ $# -gt 0 ]; then
  APPROACHES=("$@")
  echo "Running specific approaches: ${APPROACHES[*]}"
fi

# Concurrency: run N approaches in parallel, runs within each approach are sequential
CONCURRENCY=${CONCURRENCY:-${#APPROACHES[@]}}  # default: all approaches in parallel
echo "Concurrency: ${CONCURRENCY} approaches in parallel"
echo ""

run_approach() {
  local approach=$1
  local logfile="${SCRIPT_DIR}/logs/${approach}.log"
  mkdir -p "${SCRIPT_DIR}/logs"

  echo "[${approach}] Starting ${RUNS_PER_APPROACH} runs at $(date '+%H:%M:%S')" | tee "$logfile"

  for run in $(seq 1 "$RUNS_PER_APPROACH"); do
    run_build "$approach" "$run" 2>&1 | tee -a "$logfile"
  done

  echo "[${approach}] All ${RUNS_PER_APPROACH} runs complete at $(date '+%H:%M:%S')" | tee -a "$logfile"
}

# Export functions and variables for subshells
export -f run_build run_audit setup_dir get_prompt run_approach
export RUNS_PER_APPROACH MAX_TURNS SCRIPT_DIR BASE_DIR RESULTS_FILE MCP_CONFIG PRD_SOURCE SKILL_DIR

# Main execution
total_start=$(date +%s)

if [ ${#APPROACHES[@]} -eq 1 ]; then
  # Single approach: run directly
  run_approach "${APPROACHES[0]}"
else
  # Multiple approaches: run in parallel
  pids=()
  for approach in "${APPROACHES[@]}"; do
    run_approach "$approach" &
    pids+=($!)
    echo "Launched ${approach} (PID ${pids[-1]})"

    # Throttle if we've hit concurrency limit
    while [ $(jobs -r | wc -l) -ge "$CONCURRENCY" ]; do
      sleep 10
    done
  done

  # Wait for all
  echo ""
  echo "Waiting for ${#pids[@]} approach workers..."
  for pid in "${pids[@]}"; do
    wait "$pid" || echo "WARNING: PID $pid exited with error"
  done
fi

total_end=$(date +%s)
total_duration=$(( (total_end - total_start) / 60 ))

echo ""
echo "============================================"
echo "  ALL BENCHMARKS COMPLETE (${total_duration} minutes)"
echo "============================================"
echo ""

# Print summary table
printf "%-20s | %4s | %8s | %8s | %6s | %5s | %5s | %5s\n" \
  "Approach" "Runs" "Avg Time" "Avg Cost" "Turns" "MET" "PAR" "NOT"
printf "%-20s-|-%4s-|-%8s-|-%8s-|-%6s-|-%5s-|-%5s-|-%5s\n" \
  "--------------------" "----" "--------" "--------" "------" "-----" "-----" "-----"

for approach in "${APPROACHES[@]}"; do
  awk -F, -v a="$approach" '
    $1==a {
      n++
      dur += $9/1000
      cost += $8
      turns += $10
      m += $12
      p += $13
      nm += $14
    }
    END {
      if(n>0)
        printf "%-20s | %4d | %6.0fs | $%6.2f | %5.0f | %4.1f | %4.1f | %4.1f\n",
          a, n, dur/n, cost/n, turns/n, m/n, p/n, nm/n
    }
  ' "$RESULTS_FILE"
done

echo ""
echo "Full results: ${RESULTS_FILE}"
