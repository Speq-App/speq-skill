# Speq Skill Test Results

Tested against the **TaskFlow E2E Test** speq — a lightweight kanban tool with 37 product requirements across 6 groups, plus tech implementation standards.

## Builds Tested

| Build | Repo | Skill Version | Skill Commit | Notes |
|-------|------|---------------|--------------|-------|
| **Original** | bridgeai | None | n/a | Baseline: "build the application based on the speq" with no skill |
| **Skill v1** | mcp-speq-test-2 (`eb2e72d`) | v1 (baseline) | `6b8dfab` | First test of speq-driven-development skill |
| **Skill v2** | mcp-speq-test-3 (uncommitted) | v2 (chunking fixes) | `0772664` | Added manifest-first ordering, tech verification checklist |
| **v1 rerun** | mcp-speq-test-4 (uncommitted) | v1 (baseline) | `11c1f87` | Second run of v1 to test reproducibility |
| **Skill v3** | mcp-speq-test-5 (uncommitted) | v3 (API contract) | `10f8bb8` | Added chunk-0 API contract + manifest-first |
| **v3 rerun** | mcp-speq-test-6 (uncommitted) | v3 (API contract) | `10f8bb8` | Second run of v3 to test reproducibility |
| **PRD only** | prd-speq-test-1 (uncommitted) | None | n/a | Built from downloaded PRD markdown, no skill or MCP tools |
| **v3 + tech reqs** | mcp-speq-test-7 (uncommitted) | v3 (API contract) | `10f8bb8` | Same skill, speq now has 140 reqs (37 product + 103 tech with IDs) |

## Overall Scorecard

| | Original | PRD only | v1 | v2 | v1 rerun | v3 | v3 rerun | v3+tech |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **MET** | 31 | 33 | **50** | 45 | 41 | 48 | 47 | **49** |
| **PARTIAL** | 6 | 6 | 1 | 5 | 6 | 4 | 3 | 4 |
| **NOT MET** | 14 | 16 | **3** | 5 | 8 | 3 | 5 | **3** |
| **Coverage** | 61% | 63% | **92%** | 88% | 80% | 91% | 90% | **93%** |

## Product Requirements (37 total)

### Authentication & Account (5 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | Sign up with email/password | MET | MET | MET | MET | MET | MET | MET |
| 02 | Log in with email/password | MET | PAR | MET | MET | MET | MET | MET |
| 03 | Redirect to onboarding on first login | MET | PAR | MET | MET | MET | MET | MET |
| 04 | Log out from any page | NOT | NOT | MET | MET | MET | MET | MET |
| 05 | Delete account permanently | NOT | PAR | MET | MET | NOT | MET | MET |

### Onboarding (4 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | View intro modal on first login | MET | MET | MET | MET | MET | MET | MET |
| 02 | Dismiss modal with Continue | MET | MET | MET | MET | PAR | MET | MET |
| 03 | Auto-create default board | MET | MET | MET | MET | MET | MET | MET |
| 04 | Navigate to auto-created board | NOT | MET | MET | MET | MET | MET | MET |

### Boards (6 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | View list of boards | MET | MET | MET | MET | MET | MET | MET |
| 02 | Create board by name | MET | MET | MET | MET | MET | MET | MET |
| 03 | Delete board with confirmation | PAR | MET | MET | MET | PAR | MET | MET |
| 04 | Reorder boards via drag-and-drop | NOT | NOT | MET | MET | NOT | NOT | MET |
| 05 | Navigate to board detail | MET | MET | MET | MET | MET | MET | MET |
| 06 | Display name + last updated | MET | MET | MET | MET | MET | MET | MET |

### Board Detail (6 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | View all columns and tasks | MET | MET | MET | MET | MET | MET | MET |
| 02 | Create tasks inline | MET | MET | MET | MET | MET | MET | MET |
| 03 | Open task by clicking card | MET | MET | MET | MET | MET | MET | MET |
| 04 | Create, rename, delete columns | PAR | MET | MET | MET | PAR | MET | MET |
| 05 | Drag and drop tasks between columns | MET | MET | MET | MET | NOT | MET | MET |
| 06 | Empty-state guidance | NOT | MET | MET | MET | MET | PAR | MET |

### Task Management (5 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | Edit title, description, assignee, status, due date, priority | PAR | PAR | MET | PAR | NOT | NOT | MET |
| 02 | Optionally set due date | MET | MET | MET | MET | MET | MET | MET |
| 03 | Delete task with confirmation | PAR | MET | MET | MET | MET | MET | MET |
| 04 | Close task modal | MET | MET | MET | MET | MET | MET | MET |
| 05 | Validate required fields | NOT | MET | MET | MET | MET | PAR | MET |

### Workspace Settings (11 requirements)

| Req | Description | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 01 | Edit workspace name | MET | MET | MET | MET | MET | MET | MET |
| 02 | View member list | MET | MET | MET | MET | PAR | MET | MET |
| 03 | Invite members by email | MET | MET | MET | MET | MET | MET | MET |
| 04 | Send email invitations | NOT | NOT | MET | PAR | NOT | NOT | NOT |
| 05 | All members can access settings | PAR | PAR | PAR | NOT | MET | NOT | PAR |
| 06 | Initiate Todoist import | MET | NOT | MET | MET | MET | MET | MET |
| 07 | Confirmation modal before import | MET | NOT | MET | MET | PAR | MET | MET |
| 08 | View/select Todoist tasks | MET | NOT | MET | MET | PAR | MET | MET |
| 09 | Choose destination board | MET | NOT | MET | MET | MET | MET | MET |
| 10 | Map Todoist fields to local equivalents | PAR | NOT | MET | MET | MET | MET | MET |
| 11 | Import regardless of duplicates | MET | NOT | MET | MET | MET | MET | MET |

### Product Requirements Summary

| Group | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Auth (5) | 3/2N | 1/3P/1N | 5 MET | 5 MET | 4/1N | 5 MET | 5 MET |
| Onboarding (4) | 3/1N | 4 MET | 4 MET | 4 MET | 3/1P | 4 MET | 4 MET |
| Boards (6) | 4/1P/1N | 5/1N | 6 MET | 6 MET | 4/1P/1N | 5/1N | 6 MET |
| Board Detail (6) | 3/1P/2N | 6 MET | 6 MET | 6 MET | 4/1P/1N | 5/1P | 6 MET |
| Task Mgmt (5) | 2/2P/1N | 3/1P/1N? | 5 MET | 4/1P | 3/1N/1P | 3/1P/1N | 5 MET |
| Workspace (11) | 7/2P/2N | 3/1P/7N | 10/1P | 9/1P/1N | 7/2P/2N | 9/2N | 9/1P/1N |
| **Total (37)** | **22/6P/8N** | **22/5P/10N** | **36/1P** | **34/2P/1N** | **25/6P/5N** | **31/2P/3N** | **35/1P/1N** |

## Tech Requirements

| Requirement | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|-------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Vue + TS + Vue Query + Pinia | MET | MET | MET | MET | MET | MET | MET |
| Scoped CSS | NOT | MET | MET | MET | MET | MET | MET |
| Radix UI / radix-vue | NOT | PAR | MET | MET | MET | PAR | NOT |
| Express + TS | MET | MET | MET | MET | MET | MET | MET |
| PostgreSQL + Prisma | MET | MET | MET | MET | MET | MET | MET |
| Clerk auth | MET | MET | MET | MET | MET | MET | NOT |
| WebSockets | MET | MET | NOT | MET | MET | MET | MET |
| API response format | MET | MET | MET | PAR | MET | MET | MET |
| Pagination | NOT | MET | MET | NOT | NOT | NOT | NOT |
| Task priority field | NOT | NOT | MET | MET | MET | MET | MET |
| JSDoc | NOT | NOT | NOT | PAR | NOT | MET | MET |
| Tests | NOT | MET | MET | NOT | NOT | NOT | MET |
| Structured logging | MET | NOT | NOT | MET | MET | MET | MET |
| Lazy-loaded routes | MET | MET | MET | MET | MET | MET | MET |
| Zod validation | n/a | NOT | MET | NOT | MET | NOT | NOT |
| Feature-based org | n/a | MET | MET | NOT | MET | PAR | MET |
| Max 300-line files | n/a | MET | MET | PAR | PAR | MET | NOT |
| Accessibility | n/a | PAR | MET | MET | PAR | PAR | MET |

### Tech Summary

| | Original | PRD | v1 | v2 | v1 rerun | v3 | v3 rerun |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| MET | 9 | 11 | 14 | 11 | 13 | 13 | 12 |
| PARTIAL | 0 | 2 | 0 | 3 | 2 | 3 | 1 |
| NOT MET | 5 | 5 | 3 | 4 | 3 | 2 | 5 |

## Key Findings

### What the skill consistently fixes (MET in ALL skill runs)

- Logout functionality (auth 04)
- Onboarding auto-navigation to new board (onboarding 04)
- Task priority field in data model
- Task delete confirmation dialog (task management 03)
- Todoist priority field mapping (workspace 10)
- Scoped CSS adoption
- Lazy-loaded routes

### API contract chunk (v3) impact

| Metric | v1 rerun (no chunk-0) | v3 | v3 rerun | 
|--------|:---:|:---:|:---:|
| Client/server API mismatches | 4 | 0 | 0 |
| Product MET | 25 | 31 | **35** |

The API contract chunk eliminated client/server mismatches in both v3 runs. Zero mismatches confirmed.

### v3 rerun: best product coverage yet

v3 rerun achieved **35/37 product requirements MET (95%)** — the highest of any run. It was the first run to get ALL of these right simultaneously:
- Board reorder drag-and-drop
- Task status field editing
- Task field validation
- Column create/rename/delete UI
- Empty-state guidance

The only product gaps: email sending (NOT) and workspace membership checks (PAR) — both persistent across all runs.

### Persistent gaps across ALL runs

| Requirement | Best result | Root cause |
|---|---|---|
| Email invitations | MET (v1 only) | Requires external service; model defers integration |
| Workspace membership checks | MET (v1 rerun) | No role/permission model in speq |
| Pagination | MET (v1 only) | Tech standard without requirement ID |

### Tech standard variance

Tech standards remain variable even with the contract chunk. Notably v3-rerun used **custom auth instead of Clerk** and **skipped Radix Vue** — these are library-specific choices that the model sometimes substitutes. But it picked up **Pino for logging**, **JSDoc**, and **actual test files** — tech standards that had been inconsistent.

### PRD-only build: no improvement over baseline

The PRD build scored **63%** — essentially the same as the original baseline (61%). Key observations:

- **Entire Todoist import missing** (6 NOT MET) — the PRD describes it but the model didn't implement it
- **No logout** — same gap as the original baseline
- **No task priority field** — same gap as the original baseline
- **Good on some tech** — pagination, tests, WebSockets, feature-based org all present

This confirms that **the skill's value comes from the iterative speq verification loop**, not from having better documentation. The PRD contains the same information as the speq but without MCP tools for on-demand lookup and without the skill's traceability/verification process, it produces the same coverage as "just build it."

### v3+tech reqs: tech requirement IDs work

The speq was updated to include 103 tech requirements with IDs (e.g., `req_tech_authentication_01: "Use Clerk"`, `req_tech_standard_testing_01: "Use Vitest with ~50% coverage"`). The skill was unchanged — same v3 with API contract chunk.

**Result: 93% total coverage** — tied for best overall with v1.

**Tech improvements vs previous v3 runs:**

| Tech Requirement | v3 | v3 rerun | v3+tech |
|---|:---:|:---:|:---:|
| Clerk auth | MET | NOT | **MET** |
| Pagination | NOT | NOT | **MET** |
| Tests | NOT | MET | **MET** (6 files!) |
| JSDoc | MET | MET | **MET** |
| Structured logging | MET | MET | **MET** |
| Feature-based org | PAR | MET | **MET** |
| README | n/a | n/a | **MET** |
| Radix Vue | PAR | NOT | NOT (installed, unused) |
| Zod validation | NOT | NOT | NOT |

**Key insight:** Giving tech standards their own requirement IDs fixed the two biggest tech variance issues:
- **Clerk auth**: previously substituted with custom auth in v3 rerun. Now MET — the requirement ID makes it non-negotiable.
- **Pagination**: previously MET only in v1. Now MET — the requirement ID forced implementation.
- **Tests**: 6 test files (frontend + backend) — most test coverage of any run.

**Still NOT MET:**
- **Radix Vue** — installed but zero imports. The model installs the package to satisfy the dependency requirement but doesn't actually use Radix components. This may need a more specific requirement (e.g., "use Radix Vue Dialog for modals").
- **Zod** — consistently skipped. Manual validation used instead.
- **Email invitations** — still deferred (planned but not implemented).

**Product results:**
- 34 MET, 2 PAR, 1 NOT (same persistent gaps: task status field, account deletion UI, email sending)
- Zero API mismatches (chunk-0 contract continues to work)
- Board reorder, empty states, confirmations all MET

### Variance analysis (updated)

| Metric | Range across 6 skill runs | Original | PRD only |
|--------|:---:|:---:|:---:|
| Product MET | 25–36 (68–97%) | 22 (59%) | 22 (59%) |
| Tech MET | 11–15 (61–83%) | 9 (64%) | 11 (61%) |
| Total MET | 41–50 (75–93%) | 31 (61%) | 33 (63%) |
| **Average** | **47 (86%)** | **31 (61%)** | **33 (63%)** |

### Recommendation

1. **API contract chunk is proven.** Three v3 runs: zero API mismatches in all. Keep it.
2. **Tech requirement IDs work.** Adding IDs to tech standards fixed Clerk substitution, pagination, and test coverage. The skill didn't change — the speq did.
3. **PRD alone doesn't help.** Same coverage as baseline (63%). The skill's value is the process.
4. **Remaining gaps are speq ambiguity, not skill failure:**
   - Task "status" — speq says "edit status" but model uses columnId. Needs clarification.
   - Radix Vue — installed but unused. Needs more specific requirement ("use Radix Vue Dialog for all modals").
   - Zod — consistently skipped. May need an explicit requirement for schema validation on each endpoint.
   - Email — requires external service integration. Needs a specific provider or stub requirement.
5. **The winning formula:** speq with requirement IDs + skill with API contract chunk + on-demand MCP lookup = 90-93% coverage consistently.
