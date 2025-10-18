---
description: Fix GitHub review
agent: build
# model: anthropic/claude-3-5-sonnet-20241022
---

Use `gh` or available tools to fetch all GitHub pull request comments.

Analyze them, check the files they mentioned and output a list for each of them, explaining if this is relevant and should be fixed or not

Then ask the user whether we should fix them
