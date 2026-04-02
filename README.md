# speq-skill

A Claude Code skill that ensures [Speq](https://speq.dev) requirements are tracked, referenced, and verified throughout the entire development lifecycle.

## What it does

When building software from a speq specification, this skill:

- **Indexes** all requirements and screens from the speq via MCP tools
- **Self-audits** the index against phase summaries to catch gaps
- **Produces a thin spec** that references speq IDs instead of restating requirements
- **Chunks the work** into manageable plans with a manifest tracking dependencies
- **Verifies** each chunk against the speq after implementation
- **Runs a final audit** checking every requirement and tech standard

## Results

Tested against a 39-requirement speq (lightweight kanban tool):

| | Without Skill | With Skill |
|---|---------------|------------|
| Requirements MET | 61% | **92%** |
| NOT MET | 14 | **3** |
| Priority field caught | No | **Yes** |
| Confirmation dialogs | Missing | **Present** |
| Validation | Missing | **Present** |
| Empty states | Missing | **Present** |

## Install

### Option 1: Claude Code Plugin (recommended)

Install as a Claude Code plugin to make the skill available in all projects:

```bash
claude plugins add /path/to/speq-skill
```

Or install directly from GitHub:

```bash
claude plugins add Speq-App/speq-skill
```

### Option 2: Global personal skill

Copy to your personal skills directory:

```bash
mkdir -p ~/.claude/skills/speq-driven-development
cp skills/speq-driven-development/SKILL.md ~/.claude/skills/speq-driven-development/SKILL.md
```

This makes the skill available in every project.

### Option 3: Per-project

Copy into a specific project:

```bash
mkdir -p your-project/.claude/skills/speq-driven-development
cp skills/speq-driven-development/SKILL.md your-project/.claude/skills/speq-driven-development/SKILL.md
```

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- A speq with MCP tools configured (tools prefixed with `mcp__*speq*__`)
- [Superpowers](https://github.com/anthropics/claude-code-plugins) plugin — install with:

  ```bash
  claude plugins add anthropics/claude-code-plugins
  ```

  This provides the brainstorming, writing-plans, and subagent-driven-development skills that this skill orchestrates.

## Usage

The skill **auto-activates** when speq MCP tools are detected in your environment. Just tell Claude what to build:

```
> Build the application based on the speq
```

Claude will announce "Speq MCP tools detected. Using speq-driven-development..." and follow the phased process.

You can also invoke it explicitly:

```
> /speq-driven-development Build the application based on the speq
```

## Artifacts

The skill produces these files in your project:

```
docs/speq/
  manifest.md                           # Chunk tracking and status
  specs/
    YYYY-MM-DD-<feature>.md             # Thin spec with speq ID references
  plans/
    YYYY-MM-DD-<feature>-chunk-N.md     # One plan per chunk
```

## License

MIT
