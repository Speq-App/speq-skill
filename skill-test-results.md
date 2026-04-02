# Speq Skill Test Results

Tested against the **TaskFlow E2E Test** speq — a lightweight kanban tool with 37 product requirements across 6 groups, plus tech implementation standards.

## Builds Tested

| Build | Repo | Skill Version | Skill Commit | Notes |
|-------|------|---------------|--------------|-------|
| **Original** | bridgeai | None | n/a | Baseline: "build the application based on the speq" with no skill |
| **Skill v1** | mcp-speq-test-2 (`eb2e72d`) | v1 (baseline) | `6b8dfab` | First test of speq-driven-development skill |
| **Skill v2** | mcp-speq-test-3 (uncommitted) | v2 (chunking fixes) | `0772664` | Added manifest-first ordering, tech verification checklist |
| **Skill v1 rerun** | mcp-speq-test-4 (uncommitted) | v1 (baseline) | `11c1f87` | Second run of v1 skill to test reproducibility |

## Overall Scorecard

| | Original | Skill v1 | Skill v2 | Skill v1 rerun |
|---|:---:|:---:|:---:|:---:|
| **MET** | 31 | **50** | 45 | 41 |
| **PARTIAL** | 6 | 1 | 5 | 6 |
| **NOT MET** | 14 | **3** | 5 | 8 |
| **Coverage** | 61% | **92%** | 88% | 80% |

## Product Requirements (37 total)

### Authentication & Account (5 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | Sign up with email/password | MET | MET | MET | MET |
| 02 | Log in with email/password | MET | MET | MET | MET |
| 03 | Redirect to onboarding on first login | MET | MET | MET | MET |
| 04 | Log out from any page | NOT | MET | MET | MET |
| 05 | Delete account permanently | NOT | MET | MET | NOT (no backend endpoint) |

### Onboarding (4 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | View intro modal on first login | MET | MET | MET | MET |
| 02 | Dismiss modal with Continue | MET | MET | MET | PAR (client/server mismatch) |
| 03 | Auto-create default board | MET | MET | MET | MET |
| 04 | Navigate to auto-created board | NOT | MET | MET | MET |

### Boards (6 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | View list of boards | MET | MET | MET | MET |
| 02 | Create board by name | MET | MET | MET | MET |
| 03 | Delete board with confirmation | PAR | MET | MET | PAR (no confirmation dialog) |
| 04 | Reorder boards via drag-and-drop | NOT | MET | MET | NOT (client/server mismatch) |
| 05 | Navigate to board detail | MET | MET | MET | MET |
| 06 | Display name + last updated | MET | MET | MET | MET |

### Board Detail (6 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | View all columns and tasks | MET | MET | MET | MET |
| 02 | Create tasks inline | MET | MET | MET | MET |
| 03 | Open task by clicking card | MET | MET | MET | MET |
| 04 | Create, rename, delete columns | PAR | MET | MET | PAR (create endpoint mismatch) |
| 05 | Drag and drop tasks between columns | MET | MET | MET | NOT (missing move endpoint) |
| 06 | Empty-state guidance | NOT | MET | MET | MET |

### Task Management (5 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | Edit title, description, assignee, status, due date, priority | PAR | MET | PAR (no status) | NOT (no status) |
| 02 | Optionally set due date | MET | MET | MET | MET |
| 03 | Delete task with confirmation | PAR | MET | MET | MET |
| 04 | Close task modal | MET | MET | MET | MET |
| 05 | Validate required fields | NOT | MET | MET | MET |

### Workspace Settings (11 requirements)

| Req | Description | Original | Skill v1 | Skill v2 | v1 rerun |
|-----|-------------|:---:|:---:|:---:|:---:|
| 01 | Edit workspace name | MET | MET | MET | MET |
| 02 | View member list | MET | MET | MET | PAR (data shape mismatch) |
| 03 | Invite members by email | MET | MET | MET | MET |
| 04 | Send email invitations | NOT | MET | PAR | NOT (no email service) |
| 05 | All members can access settings | PAR | PAR | NOT | MET |
| 06 | Initiate Todoist import | MET | MET | MET | MET |
| 07 | Confirmation modal before import | MET | MET | MET | PAR (immediate fetch) |
| 08 | View/select Todoist tasks | MET | MET | MET | PAR (missing server endpoint) |
| 09 | Choose destination board | MET | MET | MET | MET |
| 10 | Map Todoist fields to local equivalents | PAR | MET | MET | MET |
| 11 | Import regardless of duplicates | MET | MET | MET | MET |

### Product Requirements Summary

| Group | Original | Skill v1 | Skill v2 | v1 rerun |
|-------|:---:|:---:|:---:|:---:|
| Auth (5) | 3 MET, 2 NOT | 5 MET | 5 MET | 4 MET, 1 NOT |
| Onboarding (4) | 3 MET, 1 NOT | 4 MET | 4 MET | 3 MET, 1 PAR |
| Boards (6) | 4 MET, 1 PAR, 1 NOT | 6 MET | 6 MET | 4 MET, 1 PAR, 1 NOT |
| Board Detail (6) | 3 MET, 1 PAR, 2 NOT | 6 MET | 6 MET | 4 MET, 1 PAR, 1 NOT |
| Task Mgmt (5) | 2 MET, 2 PAR, 1 NOT | 5 MET | 4 MET, 1 PAR | 3 MET, 1 NOT, 1 PAR? |
| Workspace (11) | 7 MET, 2 PAR, 2 NOT | 10 MET, 1 PAR | 9 MET, 1 PAR, 1 NOT | 7 MET, 2 PAR, 2 NOT |
| **Total (37)** | **22 MET, 6 PAR, 8 NOT** | **36 MET, 1 PAR** | **34 MET, 2 PAR, 1 NOT** | **25 MET, 6 PAR, 5 NOT** |

## Tech Requirements

| Requirement | Original | Skill v1 | Skill v2 | v1 rerun |
|-------------|:---:|:---:|:---:|:---:|
| Vue + TS + Vue Query + Pinia | MET | MET | MET | MET |
| Scoped CSS / styled-components | NOT | MET | MET | MET |
| Radix UI / radix-vue | NOT | MET | MET | MET |
| Express + TS | MET | MET | MET | MET |
| PostgreSQL + Prisma | MET | MET | MET | MET |
| Clerk auth | MET | MET | MET | MET |
| WebSockets | MET | NOT | MET | MET |
| API response format | MET | MET | PAR | MET |
| Pagination | NOT | MET | NOT | NOT |
| Task priority field | NOT | MET | MET | MET |
| JSDoc | NOT | NOT | PAR | NOT |
| Frontend tests | NOT | MET | NOT | NOT |
| Structured logging | MET | NOT | MET | MET |
| Lazy-loaded routes | MET | MET | MET | MET |
| Zod validation | n/a | MET | NOT | MET |
| Feature-based org | n/a | MET | NOT | MET |
| Max 300-line files | n/a | MET | PAR (3 violations) | PAR (4 violations) |
| Accessibility | n/a | MET | MET | PAR |

### Tech Summary

| | Original | Skill v1 | Skill v2 | v1 rerun |
|---|:---:|:---:|:---:|:---:|
| MET | 9 | 14 | 11 | 13 |
| PARTIAL | 0 | 0 | 3 | 2 |
| NOT MET | 5 | 3 | 4 | 3 |

## Key Findings

### What the skill consistently fixes (across all skill runs)

These were NOT MET in the original and became MET in all three skill runs:

- Logout functionality (auth requirement 04)
- Onboarding auto-navigation to new board (onboarding requirement 04)
- Empty-state guidance (board detail requirement 06)
- Task priority field in data model
- Task delete confirmation dialog (task management requirement 03)
- Task field validation (task management requirement 05)
- Radix Vue adoption (correct Vue equivalent of speq's Radix UI)
- Todoist priority field mapping (workspace requirement 10)

### What varies between runs (non-deterministic)

These requirements flip between MET and NOT MET across runs of the same skill:

- **Account deletion** (auth 05): MET in v1 and v2, NOT in v1-rerun
- **Board reorder** (boards 04): MET in v1 and v2, NOT in v1-rerun (API mismatch)
- **Task drag-and-drop** (board detail 05): MET in v1 and v2, NOT in v1-rerun (missing endpoint)
- **Email invitations** (workspace 04): MET in v1, PAR in v2, NOT in v1-rerun
- **Tests**: MET in v1, NOT in v2 and v1-rerun
- **Pagination**: MET in v1, NOT in v2 and v1-rerun
- **WebSockets**: NOT in v1, MET in v2 and v1-rerun

### New finding: Client/server API mismatches

The v1-rerun revealed a new failure mode not seen before: **the client and server implement different API contracts**. Examples:

- Board reorder: client sends `{ boardIds: [...] }`, server expects `{ boards: [{id, order}, ...] }`
- Column create: client calls `POST /api/boards/:id/columns`, server expects `POST /api/columns`
- Task move: client calls `PATCH /api/tasks/:id/move`, server only has `PATCH /api/tasks/:id`
- Onboarding: client sends empty body, server requires `workspaceName`

This suggests that when chunks are implemented by separate subagents, they can diverge on API contracts. The shared types package (`shared/src/types.ts`) exists in this build but may not have been used as the contract source.

### Variance analysis

| Metric | Range across 3 skill runs | Original |
|--------|:---:|:---:|
| Product MET | 25–36 (68–97%) | 22 (59%) |
| Tech MET | 11–14 (61–78%) | 9 (64%) |
| Total MET | 41–50 (75–92%) | 31 (61%) |

The skill consistently improves over the baseline, but with significant variance (75–92%). The best run (v1, 92%) may have been an outlier.

### Recommendation

1. **Product requirements**: The skill reliably improves coverage from 61% to 75-92%. The remaining variance is largely from API contract mismatches between frontend and backend chunks.
2. **API contracts**: Consider requiring a shared API contract definition (e.g., shared types, OpenAPI spec) as the first chunk, before frontend and backend implementation.
3. **Tech standards**: Giving tech standards their own requirement IDs in the speq would make them trackable through the same traceability mechanism that works well for product requirements.
4. **Tests and JSDoc**: These are consistently skipped across runs. They may need to be enforced at the chunk level (each chunk plan must include test tasks) rather than as a final verification.
