Setup the following github workflow. If this workflow already exists, see if it needs any updates, and if not, skip this step and continue with secret setting.

If other workflow files are present, read them first and add the same steps to setup the environment that is present in them.

```
name: Claude PR Assistant - Authorized Users Only

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]
  pull_request_review:
    types: [submitted]

jobs:
  claude-code-action:
    # Only respond to @claude mentions from dvcrn
    if: |
      (
        (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude')) ||
        (github.event_name == 'pull_request_review_comment' && contains(github.event.comment.body, '@claude')) ||
        (github.event_name == 'pull_request_review' && contains(github.event.review.body, '@claude')) ||
        (github.event_name == 'issues' && contains(github.event.issue.body, '@claude'))
      ) && github.actor == 'dvcrn'
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
      issues: write
      id-token: write
      actions: write
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 1

      - name: Run Claude PR Action
        uses: grll/claude-code-action@beta
        env:
          "CLAUDE_CODE_ENABLE_TELEMETRY": "0"
          "GITHUB_TOOLSETS": "repos,issues,pull_requests"
        with:
          use_oauth: true
          claude_access_token: ${{ secrets.CLAUDE_ACCESS_TOKEN }}
          claude_refresh_token: ${{ secrets.CLAUDE_REFRESH_TOKEN }}
          claude_expires_at: ${{ secrets.CLAUDE_EXPIRES_AT }}
          secrets_admin_pat: ${{ secrets.SECRETS_ADMIN_PAT }}
          allowed_tools: "Bash(git:*),Bash(bun:*),Bash(sqlite3:*),Bash(just:*),Bash(gh:*),View,GlobTool,GrepTool,BatchTool,Edit,Bash(cat:*),Bash(grep:*),Bash(bunx:*),Bash(chmod:*),mcp__github__create_or_update_file,mcp__github__search_repositories,mcp__github__create_repository,mcp__github__get_file_contents,mcp__github__push_files,mcp__github__create_issue,mcp__github__create_pull_request,mcp__github__fork_repository,mcp__github__create_branch,mcp__github__list_commits,mcp__github__list_issues,mcp__github__update_issue,mcp__github__add_issue_comment,mcp__github__search_code,mcp__github__search_issues,mcp__github__search_users,mcp__github__get_issue,mcp__github__get_pull_request,mcp__github__list_pull_requests,mcp__github__create_pull_request_review,mcp__github__merge_pull_request,mcp__github__get_pull_request_files,mcp__github__get_pull_request_status,mcp__github__update_pull_request_branch,mcp__github__get_pull_request_comments,mcp__github__get_pull_request_reviews"
          timeout_minutes: "60"
          assignee_trigger: "boticorn"
          trigger_phrase: "@boticorn"
          label_trigger: "boticorn"
          branch_prefix: "boticorn/"
          model: "claude-sonnet-4-20250514"
          custom_instructions: |
            **Git Commit Requirements (MANDATORY - NO EXCEPTIONS):**

            1. **Author Attribution**: You MUST commit as the requesting user only. NEVER include co-authoring metadata or Claude Code references in commits.

            2. **Forbidden Content**: You are STRICTLY PROHIBITED from:
               - Adding "Co-authored-by:" lines in commit messages
               - Mentioning "Claude Code" in pull request titles or descriptions
               - Using any AI assistant attribution in git history

            **WARNING: Including co-authored-by tags, Claude Code references, or AI attribution will VOID the entire commit. All work performed will be wasted and unusable.**

            3. **Commit Message Format (REQUIRED)**:
               - Start with capitalized verb (Update, Change, Add, Remove, Fix, etc.)
               - Structure: "When this commit is applied, it will [your message]"
               - Examples: "Update authentication to use OAuth2", "Remove deprecated API endpoints"
               - Include GitHub ticket reference (#xxx) ONLY if clearly inferable from changes

            4. **Pull Request Creation (MANDATORY)**:
               - After completing ANY task involving code changes, you MUST create a GitHub pull request
               - Use `mcp__github__create_pull_request` OR `gh pr create` command
               - This requirement applies to ALL completed development tasks without exception

            If any of these rules can not be fulfilled due to permission or other reasons, update the issue comment with this information, including error messages.
```

Then, retrieve the secrets out of keychain with this command:

```
security find-generic-password -s "Claude Code-credentials" -w
```

Use the `gh` CLI to set the CLAUDE secrets on the repo.
