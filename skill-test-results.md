# Speq Skill Test Results

Tested against the **TaskFlow E2E Test** speq — a lightweight kanban tool with 37 product requirements across 6 groups, plus tech implementation standards.

## Builds Tested

| Build | Repo | Skill Version | Skill Commit | Notes |
|-------|------|---------------|--------------|-------|
| **Original** | bridgeai | None | n/a | Baseline: "build the application based on the speq" with no skill |
| **Skill v1** | mcp-speq-test-2 (`eb2e72d`) | v1 (baseline) | `6b8dfab` | First test of speq-driven-development skill |
| **Skill v2** | mcp-speq-test-3 (uncommitted) | v2 (chunking fixes) | `0772664` | Added manifest-first ordering, tech verification checklist |

## Overall Scorecard

| | Original | Skill v1 | Skill v2 |
|---|:---:|:---:|:---:|
| **MET** | 31 | **50** | 45 |
| **PARTIAL** | 6 | 1 | 5 |
| **NOT MET** | 14 | **3** | 5 |
| **Coverage** | 61% | **92%** | 88% |

## Product Requirements (37 total)

### Authentication & Account (5 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | Sign up with email/password | MET | MET | MET |
| 02 | Log in with email/password | MET | MET | MET |
| 03 | Redirect to onboarding on first login | MET | MET | MET |
| 04 | Log out from any page | NOT | MET | MET |
| 05 | Delete account permanently | NOT | MET | MET |

### Onboarding (4 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | View intro modal on first login | MET | MET | MET |
| 02 | Dismiss modal with Continue | MET | MET | MET |
| 03 | Auto-create default board | MET | MET | MET |
| 04 | Navigate to auto-created board | NOT | MET | MET |

### Boards (6 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | View list of boards | MET | MET | MET |
| 02 | Create board by name | MET | MET | MET |
| 03 | Delete board with confirmation | PAR | MET | MET |
| 04 | Reorder boards via drag-and-drop | NOT | MET | MET |
| 05 | Navigate to board detail | MET | MET | MET |
| 06 | Display name + last updated | MET | MET | MET |

### Board Detail (6 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | View all columns and tasks | MET | MET | MET |
| 02 | Create tasks inline | MET | MET | MET |
| 03 | Open task by clicking card | MET | MET | MET |
| 04 | Create, rename, delete columns | PAR | MET | MET |
| 05 | Drag and drop tasks between columns | MET | MET | MET |
| 06 | Empty-state guidance | NOT | MET | MET |

### Task Management (5 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | Edit title, description, assignee, status, due date, priority | PAR | MET | PAR (no status field) |
| 02 | Optionally set due date | MET | MET | MET |
| 03 | Delete task with confirmation | PAR | MET | MET |
| 04 | Close task modal | MET | MET | MET |
| 05 | Validate required fields | NOT | MET | MET |

### Workspace Settings (11 requirements)

| Req | Description | Original | Skill v1 | Skill v2 |
|-----|-------------|:---:|:---:|:---:|
| 01 | Edit workspace name | MET | MET | MET |
| 02 | View member list | MET | MET | MET |
| 03 | Invite members by email | MET | MET | MET |
| 04 | Send email invitations | NOT | MET | PAR (relies on Clerk) |
| 05 | All members can access settings | PAR | PAR | NOT (no membership check) |
| 06 | Initiate Todoist import | MET | MET | MET |
| 07 | Confirmation modal before import | MET | MET | MET |
| 08 | View/select Todoist tasks | MET | MET | MET |
| 09 | Choose destination board | MET | MET | MET |
| 10 | Map Todoist fields to local equivalents | PAR | MET | MET |
| 11 | Import regardless of duplicates | MET | MET | MET |

### Product Requirements Summary

| Group | Original | Skill v1 | Skill v2 |
|-------|:---:|:---:|:---:|
| Auth (5) | 3 MET, 2 NOT | 5 MET | 5 MET |
| Onboarding (4) | 3 MET, 1 NOT | 4 MET | 4 MET |
| Boards (6) | 4 MET, 1 PAR, 1 NOT | 6 MET | 6 MET |
| Board Detail (6) | 3 MET, 1 PAR, 2 NOT | 6 MET | 6 MET |
| Task Mgmt (5) | 2 MET, 2 PAR, 1 NOT | 5 MET | 4 MET, 1 PAR |
| Workspace (11) | 7 MET, 2 PAR, 2 NOT | 10 MET, 1 PAR | 9 MET, 1 PAR, 1 NOT |
| **Total (37)** | **22 MET, 6 PAR, 8 NOT** | **36 MET, 1 PAR** | **34 MET, 2 PAR, 1 NOT** |

## Tech Requirements

| Requirement | Original | Skill v1 | Skill v2 |
|-------------|:---:|:---:|:---:|
| Vue + TS + Vue Query + Pinia | MET | MET | MET |
| Scoped CSS / styled-components | NOT | MET | MET |
| Radix UI / radix-vue | NOT | MET | MET |
| Express + TS | MET | MET | MET |
| PostgreSQL + Prisma | MET | MET | MET |
| Clerk auth | MET | MET | MET |
| WebSockets | MET | NOT | MET |
| API response format | MET | MET | PAR (no meta) |
| Pagination | NOT | MET | NOT |
| Task priority field | NOT | MET | MET |
| JSDoc | NOT | NOT | PAR |
| Frontend tests | NOT | MET | NOT |
| Structured logging | MET | NOT | MET |
| Lazy-loaded routes | MET | MET | MET |
| Zod validation | n/a | MET | NOT |
| Feature-based org | n/a | MET | NOT |
| Max 300-line files | n/a | MET | PAR (3 violations) |
| Accessibility | n/a | MET | MET |

## Key Findings

### What the skill consistently fixes (across both v1 and v2)

These were NOT MET in the original and became MET in both skill versions:

- Logout and account deletion (auth requirements 04, 05)
- Onboarding auto-navigation to new board (onboarding requirement 04)
- Board delete confirmation dialog (boards requirement 03)
- Board drag-and-drop reorder (boards requirement 04)
- Column rename/delete UI (board detail requirement 04)
- Empty-state guidance (board detail requirement 06)
- Task priority field in data model
- Task delete confirmation dialog (task management requirement 03)
- Task field validation (task management requirement 05)
- Todoist priority field mapping (workspace requirement 10)
- Radix Vue adoption (correct Vue equivalent of speq's Radix UI)

### What remains inconsistent

- **Tests**: v1 had frontend + backend tests; v2 had zero test files
- **WebSockets**: Original had them, v1 missed them, v2 recovered
- **Structured logging**: Original had it, v1 missed it, v2 recovered
- **Pagination**: v1 had it, v2 missed it
- **Workspace membership checks**: PARTIAL in all three builds

### Why v2 scored lower than v1

The v2 skill added explicit tech verification checklists and stricter chunking rules. Despite this, v2 scored 4% lower. Possible explanations:

1. **Non-deterministic execution** — Same skill, different results due to model variance
2. **Added verbosity may have diluted focus** — More rules didn't produce better compliance
3. **Tech standards lack speq IDs** — The skill's traceability mechanism (requirement IDs → plan tasks) works well for product requirements but doesn't apply to tech standards, which are unstructured in the speq

### Recommendation

The skill effectively solves **product requirement coverage** (61% → 92%). Improving **tech standards compliance** likely requires changes on the speq side — giving tech standards their own requirement IDs so they become first-class trackable items in the skill's traceability matrix.
