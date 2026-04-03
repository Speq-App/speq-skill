# The Evolution of speq-driven-development: From 61% to 93%

How we built and iterated on a Claude Code skill that ensures AI-generated code actually matches its specification — and the surprising things we learned along the way.

## The Problem

When you tell Claude to "build the application based on the speq," it does a reasonable job on the happy path. But it consistently misses the "invisible" requirements — confirmation dialogs, validation, empty states, logout, account deletion, and tech standards like tests and documentation. Our first build hit only 61% of requirements.

The question: can we build a skill that closes that gap, and what does it take to get there?

## The Experiment

We used a speq (specification) for a lightweight kanban tool called TaskFlow — 37 product requirements across 6 groups (auth, onboarding, boards, board detail, task management, workspace/Todoist import) plus tech implementation standards. The speq was served via MCP tools, allowing on-demand querying of requirements, screens, and phase details.

We ran 8 builds over the course of the experiment, each time auditing the implementation against all 37 requirements using parallel subagents. Every requirement was scored as MET, PARTIALLY MET, or NOT MET.

## Build 1: The Baseline (61%)

**Prompt:** "Build the application based on the speq"  
**Skill:** None  
**Result:** 22 MET, 6 PARTIAL, 8 NOT MET

The baseline build nailed the core happy path — boards, columns, tasks, basic auth. But it missed:
- No logout button anywhere in the app
- No account deletion
- No board drag-and-drop reorder (Board model lacked an `order` field)
- No column rename/delete UI (backend existed, frontend didn't expose it)
- No task priority field (mentioned in speq but absent from schema)
- No confirmation dialogs on destructive actions
- No form validation
- No empty states
- No Todoist priority field mapping
- No frontend tests

These are exactly the kinds of requirements that are easy to plan for but easy to skip under execution pressure.

## The Skill: v1 (92%)

We wrote the `speq-driven-development` skill based on the gaps we found. The core idea: treat the speq as an **external source of truth** that's referenced by ID throughout the entire development lifecycle, never copied wholesale into internal documents.

**Key mechanisms:**
1. **Phase 1 (Index & Audit):** Lightweight extraction — just requirement IDs and summaries, not full content. Self-audit against phase summaries to catch gaps.
2. **Phase 2 (Thin Spec):** Architecture decisions referencing speq IDs, not requirement restatements. Forces a tech phase data model field check.
3. **Phase 3 (Chunk & Plan):** Split by requirement group, manifest tracking, every plan task maps to speq requirement IDs. "No orphans" rule — every requirement must have a task, every task must have a requirement.
4. **Phase 4 (Execute):** Subagents fetch speq details via MCP before implementing each task.
5. **Phase 5 (Verify):** Per-chunk verification against the speq, plus final full audit.

**First test result: 50 MET, 1 PARTIAL, 3 NOT MET (92%)**

The skill fixed all the "invisible" requirements: logout, account deletion, board reorder, column CRUD UI, empty states, priority field, confirmation dialogs, validation, Todoist field mapping. It even correctly substituted Radix Vue for Radix UI (the speq specified React libraries).

## v2: More Rules, Worse Results (88%)

We added stricter rules: manifest-first ordering, explicit tech verification checklists, large group splitting. The result was worse — 88% instead of 92%.

**Lesson:** More rules didn't produce better compliance. The added verbosity may have diluted focus.

## v1 Rerun: Variance Revealed (80%)

Running the same v1 skill again produced only 80% — revealing significant non-deterministic variance. More importantly, it exposed a new failure mode: **client/server API mismatches**. When separate subagents built the frontend and backend chunks, they diverged on endpoint paths, request bodies, and response shapes. Four features were broken because the client called endpoints that didn't match the server.

## v3: The API Contract Chunk (91%)

We added a single targeted fix: **Chunk 0** — a mandatory first chunk that defines the API contract (shared types, endpoint signatures, request/response shapes) before any frontend or backend implementation.

**Result: 48 MET, 4 PARTIAL, 3 NOT MET (91%)**  
**API mismatches: zero.**

The contract chunk worked. Both v3 runs had zero client/server mismatches.

## The PRD Experiment (63% and 49%)

To isolate what was driving the improvement, we tested building from a downloaded PRD instead of using the skill + MCP tools:

- **PRD as local file + brainstorming skill:** 63% — essentially the same as the original baseline
- **PRD via MCP `get_prd` tool + brainstorming skill:** 49% — the worst result of any build

The PRD contains the same information as the speq, but without the skill's traceability mechanism and on-demand lookup, it produced baseline-level results. Front-loading the entire PRD into context actually made things *worse* — possibly by overwhelming the model instead of keeping each chunk's context focused.

**Key insight:** The skill's value is the process (traceability, verification, on-demand fetching by ID), not the document format.

## Tech Requirement IDs: The Speq-Side Fix (93%)

Throughout the experiment, tech standards (tests, JSDoc, Clerk auth, pagination, Zod validation) remained variable. The skill couldn't track them because they weren't requirements with IDs — they were unstructured prose in the tech phase.

We updated the speq to give every tech standard its own requirement ID (e.g., `req_tech_authentication_01: "Use Clerk"`, `req_tech_standard_testing_01: "Use Vitest with ~50% coverage"`). Total requirements went from 37 to 140.

**The skill was unchanged.** But because tech standards now had IDs, the skill's existing traceability mechanism automatically tracked them.

**Result: 49 MET, 4 PARTIAL, 3 NOT MET (93%)**

Key tech improvements:
- **Clerk auth:** Previously substituted with custom auth. Now MET — the requirement ID made it non-negotiable.
- **Pagination:** Previously MET only once in 5 runs. Now MET — requirement ID forced implementation.  
- **Tests:** 6 test files (best coverage ever). Previous runs: 0-1 test files.
- **JSDoc:** MET for the first time consistently.

## The "Don't Pause" Run (82%)

When we told the skill "do not pause for my input or approval," it scored 82% — lower than the 93% with approval. It skipped the manifest approval step, which meant no Chunk 0 API contract, which meant API mismatches returned.

**Lesson:** The manifest approval step isn't ceremony — it's where the chunking strategy (including Chunk 0) gets validated. Skipping it costs ~11%.

## Results Summary

| Build | Approach | Coverage |
|-------|----------|:---:|
| Original baseline | No skill | 61% |
| PRD + brainstorming | Skill + PRD file | 63% |
| PRD via MCP | Skill + `get_prd` | 49% |
| **Skill v1** | Speq skill + MCP | **92%** |
| Skill v2 | Added chunking rules | 88% |
| v1 rerun | Same v1 skill | 80% |
| **Skill v3** | Added API contract chunk | **91%** |
| v3 rerun | Same v3 skill | 90% |
| **v3 + tech IDs** | Same skill, speq updated | **93%** |
| v3 no-pause | "Don't pause for approval" | 82% |

**Average across skill runs: 86%** vs **61% baseline** — a consistent +25 percentage point improvement.

## What We Learned

### 1. On-demand beats front-loading

The PRD contains the same information as the speq, but dumping it all into context produced baseline or worse results. Fetching requirement details on demand — per chunk, per task — keeps context focused and forces the model to actually read what it's implementing.

### 2. Traceability is the mechanism

The skill's power comes from the traceability matrix: every spec section, every plan task, and every verification step maps to speq requirement IDs. The "no orphans" rule ensures nothing falls through the cracks. Without IDs, requirements are advisory. With IDs, they're trackable.

### 3. Tech standards need IDs too

Tech standards (tests, logging, auth provider, validation library) were consistently the most variable results — until we gave them requirement IDs. The skill didn't change; the speq did. The same traceability mechanism that works for "users can delete a board with confirmation" works for "use Vitest with ~50% coverage."

### 4. API contracts prevent subagent drift

When separate subagents build frontend and backend, they'll diverge on API contracts unless given a shared source of truth. Chunk 0 (API contract) eliminated 100% of client/server mismatches across three runs.

### 5. More rules ≠ better compliance

v2 added stricter verification checklists and chunking rules but scored lower than v1. The signal was diluted by the noise. The targeted fixes (API contract chunk, tech requirement IDs) worked better than broad mandates.

### 6. The approval step is load-bearing

Telling the model "don't pause for approval" dropped coverage by 11%. The manifest approval step is where Chunk 0 gets confirmed. Without it, the model makes its own infrastructure choices and skips the API contract.

### 7. Persistent gaps reveal speq ambiguity

Three requirements were NOT MET across almost every run:
- **Email invitations** — requires external service integration the model consistently defers
- **Task "status" field** — the speq says "edit status" but the implementation uses column position. This is a genuine ambiguity in the spec.
- **Workspace membership checks** — no permission model defined in the speq

These aren't skill failures — they're places where the speq itself needs clarification.

## The Winning Formula

```
Speq with requirement IDs (product + tech)
  + Skill with API contract chunk (Chunk 0)
  + On-demand MCP lookup (not front-loaded PRD)  
  + User approval at manifest step
  = 90-93% requirement coverage consistently
```

## What's Next

We're running a 40-build automated benchmark (10 runs × 4 approaches) to get statistically significant data on coverage, token usage, cost, and timing across approaches. Results will quantify the variance we've observed and determine confidence intervals for each approach.

The speq has also been updated with 140 total requirements (37 product + 103 tech), all queryable via MCP tools. The next iteration will test whether this further reduces tech standard variance at scale.
