# Development Instructions

<general-behavior>
## General Behavior & Standards

### Core Principles
- Disagree with me when I'm incorrect or say something wrong. Do not blindly accept everything I say or suggest as being the correct thing.
- Never say 'You're absolutely right!' or similar
- When the user gives you a link or URL to look at or implement, ALWAYS fetch it. Do not make assumptions of already knowing the content, you are _required_ to fetch the content of the page.
- Never make assumptions of some env var or config existing. ALWAYS do a web search, first with your built in tools, then with perplexity

### Build Systems
- Use `just` instead of `make` or other runners. Create a `justfile` if it doesn't exist yet

### Search Tools
- Use `rg` (ripgrep) instead of `grep`
</general-behavior>

<git-practices>
## Git & Version Control

### Git Commands
- NEVER add mentions to Claude Code in git commit messages or READMEs. You are to act as the current user, using information from gitconfig
- NEVER use `git add .` or `git add -A`. ALWAYS use `git status` and commit what needs to be committed.
- Whenever we're done with a task (multi-step, etc), ask me whether we should do a git commit
- **Always prefer MCP git tools** when available (e.g., `git_commit`, `git_status`, `git_diff`, `git_add`) instead of command-line `git` commands for better integration

### Commit Message Format

#### Subject Line
- **Start with a present-tense verb** (Add, Fix, Update, Refactor, Remove)
- **Capitalize the first letter**
- **Do not end with a period**
- **Keep under 50 characters**
- **NO conventional commit prefixes** (`feat:`, `fix:`, `chore:`, `docs:`, etc.)

#### Body (Optional)
- Provide concise, high-information summary of essential details
- Explain the "why" behind the change, not just the "how"
- Keep terse and to the point
- Separate from subject with blank line
- Wrap at 72 characters

#### Footer (Optional)
- Reference GitHub/Linear issues on new line after body
- Use `Fixes #123` if commit resolves the issue
- Use `Refs #456` if commit relates to but doesn't resolve issue

#### Examples

**Good:**
```
Add user authentication endpoint

Implement /login route with email and password validation.
Introduces bcrypt package for secure password hashing.

Fixes #123
```

**Bad:**
```
feat: add new login feature
```
```
fixed a bug
```
```
WIP
```
</git-practices>

<programming-language-specific-rules>
## Programming Language Specific Rules

<golang>
### Working with Go
- In Golang, when unsure about the shape of a data structure or package, use `go doc` to fetch it
</golang>

<nodejs>
### Working with Node/JavaScript

#### Package Management
- ALWAYS use `na` instead of `npm`, `bun` or `pnpm`. It's a wrapper that will automatically pick the right package manager.
  - Install: `ni webpack` or `na install webpack`
  - Install with -D: `ni @types/node -D` or `na install @types/node -D`
  - Run something: `nr` == `npm/pnpm/bun run` == `na run`
  - Uninstall: `nun webpack` or `na uninstall webpack`
- Do not put `na` `ni` or similar into any config files, those tools are only for us on this machine. The config and script files should reflect the actual package manager of the project.
- Never edit `package.json` on your own, always use the package manager to add or remove dependencies. By default, try the latest version
- Never automatically downgrade dependencies. Always check with the user before changing ANY versions of any dependencies. Assume the version is there for a reason.

#### Runtime Limitations
- You are unable to run `wrangler dev` as it's an interactive command. Don't attempt this, unless you chain it into a command to auto-kill it, or to run in the background
</nodejs>
</programming-language-specific-rules>

<secret-management>
## Secret Management

- Always use `chainenv` for secrets management and put them into .envrc
- **IMPORTANT**: Always prefix chainenv keys with the project name (eg `HOMESERVER_`) since the keychain is global
  - Store in chainenv: `chainenv update HOMESERVER_CLOUDFLARE_API_TOKEN 'value'`
  - Export in .envrc: `export CLOUDFLARE_API_TOKEN=$(chainenv get HOMESERVER_CLOUDFLARE_API_TOKEN)`
  - This prevents conflicts with other projects using the same chainenv keychain
- Example .envrc patterns:
  ```bash
  export CLOUDFLARE_EMAIL=$(chainenv get HOMESERVER_CLOUDFLARE_EMAIL)
  export CLOUDFLARE_API_TOKEN=$(chainenv get HOMESERVER_CLOUDFLARE_API_TOKEN)
  export FILEHAMSTER_PASSWORD=$(chainenv get HOMESERVER_FILEHAMSTER_PASSWORD)
  export RCLONE_CONFIG_GDRIVE_TOKEN=$(chainenv get HOMESERVER_RCLONE_CONFIG_GDRIVE_TOKEN)
  ```
- Update secrets with: `chainenv update HOMESERVER_SECRET_NAME 'value'` (not set/del)
- Read current value first to maintain format: `chainenv get HOMESERVER_SECRET_NAME`
- After a task is done, suggest copying the `chainenv` tokens over to 1Password for long-term persistency (not just local keychain). You can do that with `chainenv copy` (chainenv copy --from keychain --to 1password key1,key2,key3 --overwrite). However, as this is a GLOBAL storage across different services, make sure to prefix tokens correctly. 1Password is much slower for reading than keychain, so 1Password should act as the source of truth, but keychain should be used for actual reading.
</secret-management>

<documentation>
## Documentation & Reflection

### CLAUDE.md Creation
- When you generate a CLAUDE.md file, do not mention Claude Code in any section of it
- When creating CLAUDE.md, add applicable rules from these rules, into the local, newly created CLAUDE.md, so that other engineers can also follow the same rules.

### Post-Task Reflection
- After completing long-running tasks with user feedback, automatically reflect on learnings
- Update CLAUDE.md with new troubleshooting tips, common issues, or architectural insights
- Document any discovered patterns or gotchas for future reference
- If something is relevant globally, not just for the current project, suggest reflecting it into ~/.claude/CLAUDE.md
</documentation>

<extra-tools>
## Extra Tools

<github-issues>
### GitHub Issues

#### Proactive Issue Management
_When?_ When a GitHub issue is specified.

When working on a GitHub issue, proactively use available tools (such as `gh issue comment` or `gh issue edit`) to provide additional context and learnings when you learn something new about the issue. This is a worklog to store information and additional context.

When no Github issue is present, suggest to the user to create one. If accepted, use `gh issue create` to create a new issue.

When finishing a task, always provide a summary in the GitHub issue.

#### Available Commands

**List Issues**
```shell
gh issue list
gh issue list --state all
gh issue list --assignee @me
```

**View Issues**
```shell
gh issue view <issue-number>
gh issue view <issue-number> --comments
```

**Close Issues**
```shell
gh issue close <issue-number>
```

**Comment on Issues**
```shell
gh issue comment <issue-number> --body "Your comment here"
```

**Edit Issues**
```shell
$ gh issue edit 23 --title "I found a bug" --body "Nothing works"
$ gh issue edit 23 --add-label "bug,help wanted" --remove-label "core"
$ gh issue edit 23 --add-assignee "@me" --remove-assignee monalisa,hubot
$ gh issue edit 23 --add-project "Roadmap" --remove-project v1,v2
$ gh issue edit 23 --milestone "Version 1"
$ gh issue edit 23 --remove-milestone
$ gh issue edit 23 --body-file body.txt
$ gh issue edit 23 34 --add-label "help wanted"
```

**Help**
```shell
gh issue --help
gh issue <subcommand> --help
```
</github-issues>

<subagents>
### Subagents

You have the capability to spawn subagent using the `run_subagent_claude`. This creates another independent claude instance in the specific directory and instructs it with the given prompt.

Give the sub-agent a clear objective and a ask of what the final state should be.

Communication with the subagent happens through `check_subagent_status`. Sub-agents can ask questions for clarification, which need to be answered with the `reply_subagent`. Poll for status updates on the subagent every 30 - 60 seconds, depending on the size of the subtask.

Use subagents sparingly as they create completely autonomous instances. They are especially useful when work needs to be completed in a different project.

_Never_ use `get_subagent_logs` unless explicitely instructed, as the log output is enormous and will overload your context window.

To work on something in parallel, use `quicktree` to create a git worktree of the current repository. Always by default assume that we want a new worktree when using `subagent`.

Example, wanting to do an investigation:
```
quicktree some-investigation
```
</subagents>

<internet-search>
### Internet Search

You have access to Perplexity, a AI powered search engine. You can send queries to perplexity using the `perplexity-ask:perplexity_ask` tool. When unsure about something, or when required to research, use this tool to utilize Perplexity for web research.

Use tools like `WebSearch` and `WebFetch` for general research, these are not incurring additional cost. However, Perplexity is more advanced and will yield better results.

#### Using ask_perplexity Effectively

**Key Principle**: Natural language prompts outperform keyword searches for Perplexity due to better context handling and cited synthesis.

**Examples for General Perplexity Queries:**

1. **Natural (Recommended)**: "Analyze the impact of EU DMA regulations on app store fees for developers in 2024, including key court rulings."
   - Yields structured, sourced analysis.

2. **Natural (Recommended)**: "Compare Rust and Go for building high-concurrency web servers, focusing on memory safety and performance benchmarks."
   - Provides reasoned tradeoffs with citations.

3. **Keyword (Less Optimal)**: "EU DMA app store fees 2024 court rulings"
   - Returns fragmented snippets; lacks depth.

**MCP with ask_perplexity (Sonar API Integration):**

Structure inputs as JSON message arrays for conversational flow. Recommend leading with system role for instructions, user for query.

1. **Basic Query:**
   ```json
   [
     {"role": "system", "content": "Respond as a code expert with citations."},
     {"role": "user", "content": "Implement a binary search tree in Python with insertion and traversal methods."}
   ]
   ```
   - Processes via Sonar; outputs code with explanations.

2. **Multi-turn Context:**
   ```json
   [
     {"role": "system", "content": "Optimize for efficiency in algorithms."},
     {"role": "user", "content": "Explain quicksort time complexity."},
     {"role": "assistant", "content": "Average O(n log n), worst O(n^2)."},
     {"role": "user", "content": "Provide pivot optimization code in C++."}
   ]
   ```
   - Maintains history for refined responses.

3. **Research-focused:**
   ```json
   [
     {"role": "user", "content": "Summarize latest advancements in quantum error correction from arXiv papers since 2023."}
   ]
   ```
   - Fetches real-time web data; use high context param if chaining queries.
</internet-search>
</extra-tools>

## Gemini Added Memories
- After making code changes, always run `make format` and `make go-build` to ensure the code is formatted and builds correctly.
