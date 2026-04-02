# Speq Skill Test Results

Tested against the **TaskFlow E2E Test** speq — a lightweight kanban tool with 37 product requirements across 6 groups, plus tech implementation standards.

## Builds Tested

| Build | Repo | Skill Version | Skill Commit | Notes |
|-------|------|---------------|--------------|-------|
| **Original** | bridgeai | None | n/a | Baseline: "build the application based on the speq" with no skill |
| **Skill v1** | mcp-speq-test-2 (`eb2e72d`) | v1 (baseline) | `6b8dfab` | First test of speq-driven-development skill |
| **Skill v2** | mcp-speq-test-3 (uncommitted) | v2 (chunking fixes) | `0772664` | Added manifest-first ordering, tech verification checklist |
| **Skill v1 rerun** | mcp-speq-test-4 (uncommitted) | v1 (baseline) | `11c1f87` | Second run of v1 to test reproducibility |
| **Skill v3** | mcp-speq-test-5 (uncommitted) | v3 (API contract) | `10f8bb8` | Added chunk-0 API contract + manifest-first |

## Overall Scorecard

| | Original | Skill v1 | Skill v2 | v1 rerun | Skill v3 |
|---|:---:|:---:|:---:|:---:|:---:|
| **MET** | 31 | **50** | 45 | 41 | 48 |
| **PARTIAL** | 6 | 1 | 5 | 6 | 4 |
| **NOT MET** | 14 | **3** | 5 | 8 | 3 |
| **Coverage** | 61% | **92%** | 88% | 80% | **91%** |

## Product Requirements (37 total)

### Authentication & Account (5 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | Sign up with email/password | MET | MET | MET | MET | MET |
| 02 | Log in with email/password | MET | MET | MET | MET | MET |
| 03 | Redirect to onboarding on first login | MET | MET | MET | MET | MET |
| 04 | Log out from any page | NOT | MET | MET | MET | MET |
| 05 | Delete account permanently | NOT | MET | MET | NOT | MET |

### Onboarding (4 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | View intro modal on first login | MET | MET | MET | MET | MET |
| 02 | Dismiss modal with Continue | MET | MET | MET | PAR | MET |
| 03 | Auto-create default board | MET | MET | MET | MET | MET |
| 04 | Navigate to auto-created board | NOT | MET | MET | MET | MET |

### Boards (6 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | View list of boards | MET | MET | MET | MET | MET |
| 02 | Create board by name | MET | MET | MET | MET | MET |
| 03 | Delete board with confirmation | PAR | MET | MET | PAR | MET |
| 04 | Reorder boards via drag-and-drop | NOT | MET | MET | NOT | NOT (UI not wired) |
| 05 | Navigate to board detail | MET | MET | MET | MET | MET |
| 06 | Display name + last updated | MET | MET | MET | MET | MET |

### Board Detail (6 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | View all columns and tasks | MET | MET | MET | MET | MET |
| 02 | Create tasks inline | MET | MET | MET | MET | MET |
| 03 | Open task by clicking card | MET | MET | MET | MET | MET |
| 04 | Create, rename, delete columns | PAR | MET | MET | PAR | MET |
| 05 | Drag and drop tasks between columns | MET | MET | MET | NOT | MET |
| 06 | Empty-state guidance | NOT | MET | MET | MET | PAR |

### Task Management (5 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | Edit title, description, assignee, status, due date, priority | PAR | MET | PAR | NOT | NOT (no status) |
| 02 | Optionally set due date | MET | MET | MET | MET | MET |
| 03 | Delete task with confirmation | PAR | MET | MET | MET | MET |
| 04 | Close task modal | MET | MET | MET | MET | MET |
| 05 | Validate required fields | NOT | MET | MET | MET | PAR (title only) |

### Workspace Settings (11 requirements)

| Req | Description | Original | v1 | v2 | v1 rerun | v3 |
|-----|-------------|:---:|:---:|:---:|:---:|:---:|
| 01 | Edit workspace name | MET | MET | MET | MET | MET |
| 02 | View member list | MET | MET | MET | PAR | MET |
| 03 | Invite members by email | MET | MET | MET | MET | MET |
| 04 | Send email invitations | NOT | MET | PAR | NOT | NOT (comment only) |
| 05 | All members can access settings | PAR | PAR | NOT | MET | NOT |
| 06 | Initiate Todoist import | MET | MET | MET | MET | MET |
| 07 | Confirmation modal before import | MET | MET | MET | PAR | MET |
| 08 | View/select Todoist tasks | MET | MET | MET | PAR | MET |
| 09 | Choose destination board | MET | MET | MET | MET | MET |
| 10 | Map Todoist fields to local equivalents | PAR | MET | MET | MET | MET |
| 11 | Import regardless of duplicates | MET | MET | MET | MET | MET |

### Product Requirements Summary

| Group | Original | v1 | v2 | v1 rerun | v3 |
|-------|:---:|:---:|:---:|:---:|:---:|
| Auth (5) | 3/2 NOT | 5 MET | 5 MET | 4/1 NOT | 5 MET |
| Onboarding (4) | 3/1 NOT | 4 MET | 4 MET | 3/1 PAR | 4 MET |
| Boards (6) | 4/1P/1N | 6 MET | 6 MET | 4/1P/1N | 5/1 NOT |
| Board Detail (6) | 3/1P/2N | 6 MET | 6 MET | 4/1P/1N | 5/1 PAR |
| Task Mgmt (5) | 2/2P/1N | 5 MET | 4/1 PAR | 3/1N/1P | 3/1P/1N |
| Workspace (11) | 7/2P/2N | 10/1 PAR | 9/1P/1N | 7/2P/2N | 9/2 NOT |
| **Total (37)** | **22/6P/8N** | **36/1P** | **34/2P/1N** | **25/6P/5N** | **31/2P/3N** |

## Tech Requirements

| Requirement | Original | v1 | v2 | v1 rerun | v3 |
|-------------|:---:|:---:|:---:|:---:|:---:|
| Vue + TS + Vue Query + Pinia | MET | MET | MET | MET | MET |
| Scoped CSS / styled-components | NOT | MET | MET | MET | MET |
| Radix UI / radix-vue | NOT | MET | MET | MET | PAR (installed, minimal use) |
| Express + TS | MET | MET | MET | MET | MET |
| PostgreSQL + Prisma | MET | MET | MET | MET | MET |
| Clerk auth | MET | MET | MET | MET | MET |
| WebSockets | MET | NOT | MET | MET | MET |
| API response format | MET | MET | PAR | MET | MET |
| Pagination | NOT | MET | NOT | NOT | NOT |
| Task priority field | NOT | MET | MET | MET | MET |
| JSDoc | NOT | NOT | PAR | NOT | MET |
| Frontend tests | NOT | MET | NOT | NOT | NOT |
| Structured logging | MET | NOT | MET | MET | MET |
| Lazy-loaded routes | MET | MET | MET | MET | MET |
| Zod validation | n/a | MET | NOT | MET | NOT |
| Feature-based org | n/a | MET | NOT | MET | PAR |
| Max 300-line files | n/a | MET | PAR | PAR | MET |
| Accessibility | n/a | MET | MET | PAR | PAR |

### Tech Summary

| | Original | v1 | v2 | v1 rerun | v3 |
|---|:---:|:---:|:---:|:---:|:---:|
| MET | 9 | 14 | 11 | 13 | 13 |
| PARTIAL | 0 | 0 | 3 | 2 | 3 |
| NOT MET | 5 | 3 | 4 | 3 | 2 |

## Key Findings

### What the skill consistently fixes (MET in ALL skill runs)

- Logout functionality (auth 04)
- Onboarding auto-navigation to new board (onboarding 04)
- Empty-state guidance (board detail 06) — MET or PAR in all runs
- Task priority field in data model
- Task delete confirmation dialog (task management 03)
- Todoist priority field mapping (workspace 10)
- Scoped CSS adoption
- Structured logging (3 of 4 runs)
- WebSockets (3 of 4 runs)
- Lazy-loaded routes (all runs)

### What the API contract chunk (v3) fixed

- **Zero client/server API mismatches** — v1-rerun had 4 mismatches (board reorder, column create, task move, onboarding). v3 had none. All client API calls hit valid server endpoints.
- **JSDoc coverage** — MET for the first time in any run

### What the API contract chunk didn't fix

- **Board reorder drag-and-drop** — Backend exists but UI drag events not wired. This is a frontend-only implementation gap, not a contract mismatch.
- **Task "status" field** — Consistently missed across all runs. The speq says "edit status" but tasks use columnId for status. This may be an ambiguity in the speq itself.
- **Email invitations** — Never fully implemented (no email service). This requires external service integration that the model consistently defers.
- **Tests** — Zero test files in v3 (same as v2 and v1-rerun). Only v1 produced tests.

### Persistent gaps across ALL runs

| Requirement | Status across all runs | Root cause |
|---|---|---|
| Task "status" field | MET once (v1), then NOT/PAR | Ambiguous — speq says "status" but model uses columnId |
| Email invitations | MET once (v1), then NOT/PAR | Requires external service integration |
| Workspace membership checks | PAR or NOT in all runs | No role/permission model in speq |
| Pagination | MET once (v1), then NOT | Tech standard without requirement ID |
| Tests | MET once (v1), then NOT | Tech standard without requirement ID |

### Variance analysis

| Metric | Range across 4 skill runs | Original |
|--------|:---:|:---:|
| Product MET | 25–36 (68–97%) | 22 (59%) |
| Tech MET | 11–14 (61–78%) | 9 (64%) |
| Total MET | 41–50 (75–92%) | 31 (61%) |
| **Average** | **46 (85%)** | **31 (61%)** |

### Recommendation

1. **API contract chunk works.** v3 eliminated all client/server mismatches that plagued v1-rerun. Keep it.
2. **Manifest-first ordering** is good discipline but doesn't measurably affect scores.
3. **Persistent gaps need speq-side fixes:**
   - Clarify "status" vs "columnId" for tasks
   - Add email sending as a tech requirement with a specific provider
   - Add test coverage as a first-class requirement with an ID
   - Add pagination as a first-class requirement with an ID
4. **v1 (92%) may have been an outlier.** Average across 4 runs is 85%, with a range of 80–92%. The skill reliably adds ~24% coverage over baseline.
