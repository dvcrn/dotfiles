- NEVER add mentions to Claude Code in git commit messages or READMEs. You are to act as the current user, using information from gitconfig
- Use `rg` (ripgrep) instead of `grep`
- When you generate a CLAUDE.md file, do not mention Claude Code in any section of it
- Disagree with me when I'm incorrect or say something wrong. Do not blindly accept everything I say or suggest as being the correct thing.
- Use `just` instead of `make` or other runners. Create a `justfile` if it doesn't exist yet
- Never say 'You're absolutely right!' or similar
- NEVER use `git add .` or `git add -A`. ALWAYS use `git status` and commit what needs to be committed.
- When the user gives you a link or URL to look at or implement, ALWAYS fetch it. Do not make assumptions of already knowing the content, you are _required_ to fetch the content of the page.
- never make assumptions of some env var or config existing. ALWAYS do a web search, first with your built in tools, then with perplexity
- Whenever we're done with a task (multi-step, etc), ask me whether we should do a git commit
- You are unable to run `wrangler dev` as it's an interactive command. Don't attempt this, unless you chain it into a command to auto-kill it, or to run in the background
- ALWAYS use `na` instead of `npm`, `bun` or `pnpm`. It's a wrapper that will automatically pick the right package manager.
  - Install: `ni webpack` or `na install webpack`
  - Install with -D: `ni @types/node -D` or `na install @types/node -D`
  - Run something: `nr` == `npm/pnpm/bun run` == `na run`
  - Uninstall: `nun webpack` or `na uninstall webpack`
- Do not put `na` `ni` or similar into any config files, those tools are only for us on this machine. The config and script files should reflect the actual package manager of the project.
- Never automatically downgrade dependencies. Always check with the user before changing ANY versions of any dependencies. Assume the version is there for a reason.

### Commit message

Start the message with what the commit does, a verb, first letter capitalized. Eg Update xxx to yyy, Change bbb to better ccc, and so on. When reading the log, we should be able to read it as 'When this commit is applied, it will <followed by the commit message>'. DO NOT use `chore:` `feat:` `docs:` or any of this, I don't like this style.

If a GitHub or Linear issue is available, make sure you mention it in the end on a new line, eg `Ref #13`

### Secret Management

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

### Post-Task Reflection

- After completing long-running tasks with user feedback, automatically reflect on learnings
- Update CLAUDE.md with new troubleshooting tips, common issues, or architectural insights
- Document any discovered patterns or gotchas for future reference
- If something is relevant globally, not just for the current project, suggest reflecting it into ~/.claude/CLAUDE.md

### CLAUDE.md creation

When creating CLAUDE.md, add applicable rules from these rules, into the local, newly created CLAUDE.md, so that other engineers can also follow the same rules.

### Proactive issue management

_When?_ When a GitHub issue is specified.

When working on a GitHub issue, proactively use available tools (such as `gh issue comment` or `gh issue edit`) to provide additional context and learnings when you learn something new about the issue. This is a worklog to store information and additional context.

When no Github issue is present, suggest to the user to create one. If accepted, use `gh issue create` to create a new issue.

When finishing a task, always provide a summary in the GitHub issue.

### Additional tools

#### Managing GitHub issues

You have access to `gh` to interact with GitHub issues

### List Issues

```shell
gh issue list
gh issue list --state all
gh issue list --assignee @me
```

### View Issues

```shell
gh issue view <issue-number>
gh issue view <issue-number> --comments
```

### Close Issues

```shell
gh issue close <issue-number>
```

### Comment on Issues

```shell
gh issue comment <issue-number> --body "Your comment here"
```

### Edit Issues

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

## Help

```shell
gh issue --help
gh issue <subcommand> --help
```

- In Golang, when unsure about the shape of a data structure or package, use `go doc` to fetch it

## Subagents

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

## Internet search

You have access to Perplexity, a AI powered search engine. You can send queries to perplexity using the `perplexity-ask:perplexity_ask` tool. When unsure about something, or when required to research, use this tool to utilize Perplexity for web research.

Use Perplexity sparingly as each request costs money.

Use tools like `WebSearch` and `WebFetch` for general research, these are not incurring additional cost. However, Perplexity is more advanced and will yield better results.
