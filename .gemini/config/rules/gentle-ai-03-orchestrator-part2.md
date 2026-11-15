---
trigger: model_decision
description: "Gentle AI orchestrator guidance (part 2 of 2); read this file before work that involves: Allowed edit surfaces (MANDATORY)"
---

### Allowed edit surfaces (MANDATORY)

A bounded writer refuses to write outside the exact allowed edit surfaces and stops for interaction when they are missing. The parent owns that input. Every new writer launch carries the section (a continuation inherits it); after a rejected launch, repair what the rejection names once, never relaunch the same prompt unchanged.

Before launching a bounded writer through the runtime's delegation mechanism, derive the allowed edit surface from the task being delegated — the files the planned change must touch, plus the directories where the task authorizes new files — and pass it in the delegated prompt under an `## Allowed edit surfaces` heading:

- exact repository-relative paths or narrow globs, one per line; never `.`, a bare repository root, or an absolute path; paths containing whitespace require whole-entry backticks;
- the section ends at the next Markdown heading; every non-empty line before it must be a valid surface entry, so put explanatory prose under a following heading;
- pre-existing untracked targets the writer may write, listed explicitly;
- the directories where new files are authorized, when the task requires new files;
- nothing beyond the delegated task — a surface wider than the task is the same defect as no surface at all.

If the surface genuinely cannot be derived, do not launch the writer, and do not ask the human to author paths. Derive a candidate set first — the exact paths this task would touch — and present that enumerated list as an approve/decline choice under the Lossless Blocking Prompts rules.

Relay a writer's interaction request about edit surfaces the same way: present its derived candidate paths as the choice, and add or drop paths only on the human's explicit instruction.

### Key Learnings closing block

When delegating to a generic exploration, writer, or verification worker, include the same `## Key Learnings` closing instruction in the delegated prompt: after the worker returns its normal result envelope or handoff, it closes its final response text with a `## Key Learnings` block of 1–5 numbered items, each a standalone factual sentence of at least 20 characters and at least 4 words, omitting the block when there is genuinely no reusable learning. The block layers on after the structured return contract and does not alter its fields. This applies to final response text only — not intermediate tool output. The Engram memory provider extracts and persists these items as passive capture; the worker does not parse the block or invoke passive-capture tools itself. This is separate from explicit `mem_save` persistence. Agents that must return strict JSON never receive this closing instruction; their required output shape remains unchanged.

### Delivery strategy

Use the ODD delivery strategy and work-unit boundaries under `## Implementation Routing`. Push, PR creation, and merge remain human decisions.

### Intent-Driven Skill Discovery

For skill-shaped requests, do not treat the injected skill list as complete. Use the skill registry and filesystem only as a discovery aid; do not let a trigger table override the user's concrete request or turn a small request into a larger workflow.

Discovery order:

1. Read `.atl/skill-registry.md` when present.
2. If the registry suggests a specific skill, load the indexed `SKILL.md` path before acting.
3. If the expected skill is absent from the registry but the request clearly names a known workflow, search common project/user skill directories such as `./skills`, `.agents/skills`, `~/.config/opencode/skills`, `~/.claude/skills`, and other configured skill roots.
4. Prefer the most specific project skill over a global skill with the same intent.
5. If no matching skill exists, continue with the smallest safe fallback and say which expected skill was unavailable.

Common intent hints, not hard routing:

| User intent                | Skill to check                         |
| -------------------------- | -------------------------------------- |
| PR review / GitHub PR URL  | project review skill, then `pr-review` |
| Post-ready review comments | `comment-writer`                       |
| Create/open/prepare PR     | `branch-pr`                            |
| Split/stack/large PR       | `chained-pr`                           |

Keep this lightweight: loading a skill should improve the immediate task, not force extra ceremony.

### Safety

- Never commit unless the user explicitly asks, except the work-unit commits that authorized substantial ODD implementation makes on its feature branch under `## Implementation Routing`.
- Ask before destructive git operations, publishing, or irreversible file changes.
- Parallel writers follow the **Parallel writers** rule under `## Implementation Routing`: another repository's work goes in a fresh worktree based on its main; parallel units in the same local repository share the tree only with declared disjoint edit surfaces, the parent owning git; units that need the same file use isolated worktrees.
- Preserve human control: user decisions beat agent momentum.

### Dynamic Subagent Launch Deduplication (MANDATORY)

Before invoking any dynamic bounded worker via `invoke_subagent`, check your in-session launch log:

- Maintain a session-scoped list of `(role, task-fingerprint)` pairs already invoked this turn.
- The task fingerprint is a short hash or normalized summary of the task instruction text.
- If the same `(role, task-fingerprint)` already appears in the list, **do NOT invoke again**. Emit exactly one invocation per distinct task.
- After invoking, append the pair to the list.

This prevents duplicate dynamic subagent invocations that cause "File X has been modified since it was last read" conflicts and waste tokens.

### Skill Resolver Protocol

Skill resolution is orchestrator-owned before each dynamic worker invocation. Do this ONCE per session (or after compaction):

1. `mem_search(query: "skill-registry", project: "{project}")` → `mem_get_observation(id)` for full registry content
2. Fallback: read `.atl/skill-registry.md` if engram not available
3. Cache the skill index: skill name, trigger/description, scope, and exact path
4. If no registry exists, warn user and proceed without project-specific standards

Before invoking each worker:

1. Match relevant skills by **code context** (file extensions/paths the worker will touch) AND **task context** (what actions it will perform — review, PR creation, testing, etc.)
2. Pass matching exact `SKILL.md` paths to the worker task
3. Tell the worker to read those skill files before work — they inform how it writes code and validates output

**Key rule**: use paths, not generated summaries. Read the full `SKILL.md` files so author intent is preserved. This is compaction-safe because you re-read the registry if the cache is lost.

### Skill Resolution Feedback

After each worker returns, check the `skill_resolution` field in the result:

- `paths-injected` → all good, exact skill paths were loaded
- `fallback-registry`, `fallback-path`, or `none` → skill cache was lost (likely compaction). Re-read the registry immediately and load skill paths for all subsequent phases.

This is a self-correction mechanism. Do NOT ignore fallback reports — they indicate you dropped context between delegations.

### ODD Work and Memory Context

Before invoking a bounded worker, pass authorized edit surfaces, acceptance criteria, the applicable test-first policy and runner from `## Implementation Routing`, applicable verification commands, and relevant prior context explicitly. Workers preserve unrelated working-tree changes and return observed outcomes and checks. Keep one writer per unit.

Search engram (`mem_search`) for relevant prior context before starting when available. Save significant verified discoveries, decisions, or bug fixes via `mem_save`; do not rely solely on conversation history for cross-session continuity.

## State and Conventions

Convention files under `~/.gemini/config/skills/_shared/` (global), `.agents/skills/_shared/` (workspace), or legacy `.agent/skills/_shared/` (workspace fallback): `engram-convention.md`, `persistence-contract.md`.
