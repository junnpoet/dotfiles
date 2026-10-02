Engram provides persistent memory that survives across sessions and compactions.

CORE TOOLS (always available — use without ToolSearch):
  mem_save — save decisions, bugs, discoveries, conventions PROACTIVELY (do not wait to be asked)
  mem_search — find past work, decisions, or context from previous sessions
  mem_context — get recent session history (call at session start or after compaction)
  mem_session_summary — save end-of-session summary (MANDATORY before saying "done")
  mem_get_observation — get full untruncated content of a search result by ID
  mem_save_prompt — save user prompt for context
  mem_current_project — detect current project from cwd (recommended first call)

DEFERRED TOOLS (use ToolSearch when needed):
  mem_update, mem_review, mem_pin, mem_unpin, mem_suggest_topic_key, mem_session_start, mem_session_end,
  mem_stats, mem_delete, mem_timeline, mem_capture_passive, mem_merge_projects

PROACTIVE SAVE RULE: Call mem_save immediately after ANY decision, bug fix, discovery, or convention — not just when asked.

## CONFLICT SURFACING — when mem_save returns candidates

After every mem_save call, check the response envelope for judgment_required.

IF judgment_required IS TRUE:
  Iterate candidates[] and call mem_judge once per candidate using the
  judgment_id from that candidate entry. Do NOT use the top-level judgment_id
  for multiple candidates — each candidate has its own.

  HEURISTIC — when to ask the user vs. resolve autonomously:

  ASK the user (conversationally, as part of your next reply) when:
    - confidence is below 0.7, OR
    - the relation you would choose is supersedes or conflicts_with AND the
      observation type is architecture, policy, or decision

  RESOLVE silently (call mem_judge without asking) when:
    - confidence >= 0.7 AND the relation is not supersedes/conflicts_with, OR
    - the relation is related, compatible, scoped, or not_conflict

  HOW TO ASK (conversationally — never via blocking CLI or dashboard prompt):
    Raise it naturally in your next reply to the user. Example phrasing:
    "I noticed memory #abc123 might conflict with what we just saved.
     Want me to mark the new one as superseding it, or are they about
     different scopes? I can also mark them as compatible if both still apply."

  AFTER RESOLUTION (both paths):
    Call mem_judge with the chosen relation, a reason, and if the user gave
    explicit direction, include their words as the evidence field. This persists
    the verdict and closes the pending conflict row.