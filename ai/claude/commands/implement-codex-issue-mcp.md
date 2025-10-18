You are tasked with implementing a GitHub issue.

  Objective: Get instructions for a specific GitHub issue, do research, and implement it from start to finish.

  These MCP GitHub tools are available for interacting with issues:

  - Create a GitHub comment: Use mcp__github__add_issue_comment tool
  - Fetch a GitHub issue: Use mcp__github__get_issue tool
  - Update issue description/labels: Use mcp__github__update_issue tool
  - List issues: Use mcp__github__list_issues tool
  - Create pull request: Use mcp__github__create_pull_request tool

  Fetch the next issue labeled 'codex'. If no issue exists, state this and stop. If more than 1 issue exists, pick the first.
  Use mcp__github__list_issues with labels: ["codex"] to find available issues. Do NOT work on any issues that are not labeled
  'codex'. If the issue already has a `AI In Progress` or `AI Done` label, skip it. We only work on issues without `AI In Progress` or `AI Done`.

  You are to run fully autonomous without any user feedback. If under some circumstances you cannot continue or don't know what the right
  way forward is, add a comment to the GitHub issue and stop processing any further.
  Because you run autonomous, be verbose in your communication. Add GitHub comments whenever you are done with one of the phases.
  Commit often and push your branch after each commit.

  Then do the following steps in order:

  1. Check if the information in the issue is sufficient
    - Check if the issue has the 'codex' label
    - If not enough information is present, use mcp__github__add_issue_comment to state this
    - If the information is sufficient, proceed to the next step

  2. Create an implementation plan (skip if GitHub issue already contains a detailed plan)
    - Switch back to the main branch, make sure all changes are stashed or reset, then do a git pull to make sure we're on the latest main.
  Use git status to make sure we don't have any changes. Remove all changed files.
    - Run bun install
    - Read the codebase and research the files that need to be updated and changed
    - Do not do any implementation yet, simply research and output a HIGH LEVEL plan
    - Chunk the plan into logical steps, think user stories or subtasks
    - Use mcp__github__add_issue_comment to add the plan as a comment

  3. Create a git branch
    - Use the command git checkout -b <branch-name> to create a new branch for the task
    - Make sure to use a descriptive name for the branch
    - Use the GitHub issue number in the branch name (e.g., fix-123-user-auth)
    - Update the issue by adding 'AI In Progress' label using mcp__github__update_issue

  4. Implement a test (skip if not needed)
    - Determine if a unit test is needed based on the complexity of the task
    - Small UI changes don't need tests
    - If determined to be needed, read docs/guides/testing-guide-concise.md
    - Always make sure the test you created is failing first, before implementing

  5. Implement the task
    - Write the code based on the plan, focus on smaller file changes instead of bigger ones all at once
    - After EACH logical step from the plan, make a commit with all changed files, do not use git add ., specify exactly which files to
  commit
    - Use git status to figure out what changed
    - Always run bun format and bun run build-without-gen to enforce formatting and build the project. It's only considered complete when
  build passes.
    - (If there are schema changes, use bun run build instead of build-without-gen)
    - Only fix warnings for files you wrote, but build errors are always to be fixed.

  6. Push the branch
    - Use the command git push -u origin <branch-name> to push the branch to the remote repository
    - Make sure to create a pull request for the changes

  7. Create a pull request
    - Use mcp__github__create_pull_request with descriptive title and body
    - Include "Fixes #" in the PR body to link it to the issue
    - Set the base branch to "main" and head to your branch name

  8. Write a report
    - Write a report on the implementation and use mcp__github__add_issue_comment to add it to the issue
    - Include the following sections:
        - Summary of the task
      - Implementation details
      - Challenges faced
      - Future improvements
    - Use markdown format for the report
    - Include the link to the PR, and the branch that you created
    - Update the issue by removing 'AI In Progress' label and adding 'AI Done' label using mcp__github__update_issue