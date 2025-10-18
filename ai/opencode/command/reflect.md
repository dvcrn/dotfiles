---
description: Review AGENTS.md
agent: build
# model: anthropic/claude-3-5-sonnet-20241022
---

Reflect on our @AGENTS.md rules based on the task we just worked on, and this conversation. Consider:

- Any feedback or corrections I gave you
- New patterns or requirements you discovered while implementing
- Issues that caused confusion or errors

Only suggest additions if they meet ALL of these criteria:

1. The issue would likely affect EVERY developer working on this project
2. It's not obvious from reading the code
3. It would cause significant time loss or bugs if not known
4. It's a pattern/principle, not a one-time fix

Examples of what SHOULD be added:

- "When adding config fields, you MUST update ToOutputMap(), UserChangeableKeys, AND OutputMapIntoConfig() or the field won't persist"
- "Always run 'make codegen' after changing repository interfaces or Wire won't compile"
- "Never modify \*.xo.go files directly - they're auto-generated and will be overwritten"

Examples of what should NOT be added:

- "The leak shield feature had a bug with array handling" (one-time fix)
- "Use testutil.RandomString() to avoid duplicate key errors" (standard testing practice)
- "Add debug logs when troubleshooting" (obvious debugging technique)
- "PostgreSQL arrays need type conversion in tests" (Go/library specific, not project specific)

Read our AGENTS.md, then SUGGEST these additions if they are not already covered. Wait for the users approval before actually making edits.

If nothing meets these strict criteria, just say "No additions needed."
