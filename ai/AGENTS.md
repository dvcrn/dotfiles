# Development Instructions

<general-behavior>
## General Behavior & Standards

### Core Principles
- Disagree with me when I'm incorrect or say something wrong. Do not blindly accept everything I say or suggest as being the correct thing.
- Never say 'You're absolutely right!' or similar
- When the user gives you a link or URL to look at or implement, ALWAYS fetch it. Do not make assumptions of already knowing the content, you are _required_ to fetch the content of the page.
- Never make assumptions of some env var or config existing. ALWAYS do a web search, first with your built in tools, then with perplexity

### Build Systems
- Use `mise` instead of `make` or other runners. Create a `mise.toml` if it doesn't exist yet
- Example mise tasks in `mise.toml`:
  ```toml
  [tasks.build]
  run = "go build -o ./bin/copilot-proxy ./cmd/copilot-api-proxy"
  description = "Build the application binary"
  ```

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
- **Fallback**: Use command-line `git` commands via the `terminal` tool when MCP tools are not available

Always prefer creating git commits with `git_commit` (not `git status`)
Always prefer the status with `git_status` (not `git status`)
Always prefer the diff with `git_diff` (not `git diff`)
Always prefer to add files with `git_add` (not `git add`)

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
- ALWAYS use `bun` unless the repository has a specific package manager configured (check for `package-lock.json`, `pnpm-lock.yaml`, or `yarn.lock`)
  - Install: `bun add webpack`
  - Install with -D: `bun add -D @types/node`
  - Run something: `bun run <script>`
  - Uninstall: `bun remove webpack`
- If the repo has existing lock files for other package managers, respect that choice and use the appropriate manager (`npm`, `pnpm`, or `yarn`)
- Never edit `package.json` on your own, always use the package manager to add or remove dependencies. By default, try the latest version
- Never automatically downgrade dependencies. Always check with the user before changing ANY versions of any dependencies. Assume the version is there for a reason.
- When working in a project, automatically document the package manager being used in CLAUDE.md if it's not already documented there

#### Version management

We use `mise` to manage versions of installed languages (preferred over tools like `asdf`)

Example `mise.toml` configuration:
```toml
[tools]
go = "1.25.1"
```

#### Runtime Limitations
- You are unable to run `wrangler dev` as it's an interactive command. Don't attempt this, unless you chain it into a command to auto-kill it, or to run in the background
- When using `fly logs`, always use `--no-tail`
</nodejs>
</programming-language-specific-rules>

<secret-management>
## Secret Management

- Use `mise` + chainenv plugin to manage secrets via `mise.toml` (not justfile or .envrc by default).
- Prefix chainenv keys with the project name (e.g., `CLOUDMCP_`) to avoid global key conflicts.
- Install the plugin and tool:
  ```bash
  mise plugin install chainenv https://github.com/dvcrn/mise-chainenv --force
  mise install chainenv
  ```
- Add chainenv to `[tools]` and declare secrets under `[env]`:
  ```toml
  [tools]
  elixir = "1.18.4-otp-27"
  erlang = "27.2"
  chainenv = "latest"

  [env]
  # Resolution rule: Any key starting with CHAINENV_ is fetched as `chainenv get <suffix>`
  # Example: CHAINENV_BAR -> `chainenv get BAR` (prefix is stripped)
  CHAINENV_CLOUDMCP_SUPABASE_ANON_KEY = { value = "", tools = true, chainenv_backend = "keychain" }
  CHAINENV_CLOUDMCP_SUPABASE_JWT_SECRET = { value = "", tools = true, chainenv_backend = "keychain" }

  # Export app-facing variables by referencing the resolved CHAINENV_* values
  SUPABASE_ANON_KEY  = { value = "{{env.CHAINENV_CLOUDMCP_SUPABASE_ANON_KEY}}", tools = true, chainenv_backend = "keychain" }
  SUPABASE_JWT_SECRET = { value = "{{env.CHAINENV_CLOUDMCP_SUPABASE_JWT_SECRET}}", tools = true, chainenv_backend = "keychain" }
  ```
- Resolution rules:
  - Any `[env]` key named `CHAINENV_<NAME>` triggers the plugin to run `chainenv get <NAME>`.
  - Do not include the `CHAINENV_` prefix in the stored secret name. For example, to read secret `BAR`, define `CHAINENV_BAR` in `mise.toml`.
  - `tools = true` makes variables available to tasks and tools run by mise.
  - `chainenv_backend = "keychain"` selects the Keychain backend for reads.
- Managing values:
  - Update secrets: `chainenv update CLOUDMCP_SUPABASE_ANON_KEY 'value'`
  - Read current value: `chainenv get CLOUDMCP_SUPABASE_ANON_KEY`
  - After tasks, consider copying secrets to 1Password for long-term storage: `chainenv copy --from keychain --to 1password key1,key2 --overwrite`
- If a project still uses a `justfile`, export variables with chainenv directly when needed, for example:
  `export RCLONE_CONFIG_GDRIVE_TOKEN=$(chainenv get HOMESERVER_RCLONE_CONFIG_GDRIVE_TOKEN)`
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

When working on a GitHub issue, proactively use available tools to provide additional context and learnings when you learn something new about the issue. This is a worklog to store information and additional context.

When no Github issue is present, suggest to the user to create one. If accepted, create a new issue using available tools.

When finishing a task, always provide a summary in the GitHub issue.

#### Tool Preference
- **Primary**: Use GitHub API tools when available (`search_issues`, `get_issue`, `create_issue`, `list_issues`, `get_issue_comments`, `add_issue_comment`, `update_issue`)
- **Fallback**: Use `gh` CLI commands when API tools are not available (`gh issue view`, `gh issue view --comments`, `gh issue edit`, `gh issue --help`)
</github-issues>




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
