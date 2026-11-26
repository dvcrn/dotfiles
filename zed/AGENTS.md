## CRITICAL: Tool Use Restrictions

You are STRICTLY FORBIDDEN from using standard Unix commands for file manipulation (`cat`, `sed`, `echo`, `mv`, `mkdir`, etc.) in the terminal. You must ONLY use the provided native tools.

Failing to use native tools causes formatting errors and context-window bloat.

**DO NOT** do this:

- `terminal("cat file.swift")` (BAD)
- `terminal("echo 'code' > file.swift")` (BAD)
- `terminal("sed -i ...")` (BAD)

**DO THIS** instead:

- Use `read_file` to read files.
- Use `write_file` or `edit_file` for file creation and modification.
- Use `move_path` for renaming or moving files.
- Use `copy_path`, `create_directory`, `list_directory`.
- Use `grep` (the built-in tool) or `find_path` for searching code.
- Use `spawn_agent` to spawn sub-agents and delegate tasks. This is very helpful for handling multiple tasks in parallel. Use this for exploration, coding tasks, investigation, etc.

Only use `terminal` for actual build scripts, running the app, or explicitly requested git operations.

Use `spawn_agent` whenever you need to parallelize some tasks. It's a very powerful tool and should be used often. Be VERY DESCRIPTIVE with what you want the subagent to do, as the subagent will have none of your context. Think of this as delegating a task to a different engineer.

Again, DO NOT use `cat` to read files, or `sed` / unix pipes to write files

You ARE permitted to use `rg` for more exact search if the built-in `grep` tool is not sufficient.

## Agy / Codex override

**ANY** skills and commands that use `agy` or `codex` CLI to do a code review, ask questions, simplify or similar should NOT use the external CLI. Instead, Zed should use `spawn_agent` with the appropriate model and paste the prompt it would give to agy/codex into `spawn_agent()` instead. All skills should be passed as skill names, not as full path.

eg `agy --model "Gemini 3.8 Flash (High)" ....` -> `spawn()` with google/gemini-3.8-flash-high

## Commit message format

Start commit messages with a verb of what the change is doing, eg "Add xxxx", "Update yyy", "Change xxx to yyyy" for the first line.

For the body, keep a concise HIGH-LEVEL explanation of what this change is doing and why in bullet points. Don't be too wordy. Avoid going into too much implementation detail and keep it high level. In bullet points.

## Search Tool Preferences

Web search goes through the `Search` MCP portal, using `mcp_Search_portal_codemode_execute`. Tools are called as `codemode.<name>({...})` inside an async arrow function. Run several searches in parallel with `Promise.all` and trim the output in code, since raw results are large. Some tools return `[{type:"text", text}]` arrays, others plain objects. Use `portal_codemode_search` to look up a tool's schema.

Pick by need:

1. **Quick fact or version check**: `ask_antigravity_google_search({query})`. It returns a synthesized `answer` plus `sources`. Ask a full question. It takes about 7s and comes from a small model, so check the sources for anything important.
2. **General search, fast**: `exa_web_search_exa({query, numResults})` (~1s). Use `search_tools_brave__brave_web_search({query, count})` as the second opinion or for news (`brave_news_search`, with `freshness`).
3. **Content for grounding**: `parallel_web_search({objective, search_queries})` returns long, relevant excerpts. `search_tools_brave_search__brave_llm_context({query, maximum_number_of_tokens})` is similar (the token limit must be at least 1024).
4. **Reading a known URL**: `exa_web_fetch_exa({urls})` or `tavily_tavily_extract({urls})`.
5. **Deep research**: `exa_agent_run`, `tavily_tavily_research`, or `linkup_linkup_research`. These are slow and use more of the free quota, so use them only when a few searches won't do.

Search results can be stale. Cross-check version numbers and dates across two tools.

Example, parallel search with trimmed output:

```js
async () => {
  const q = "latest stable Go release";
  const [exa, brave, google] = await Promise.all([
    codemode.exa_web_search_exa({ query: q, numResults: 3 }),
    codemode.search_tools_brave__brave_web_search({ query: q, count: 3 }),
    codemode.ask_antigravity_google_search({
      query: "What is the latest stable version of Go?",
    }),
  ]);
  const text = (r) =>
    r
      .map?.((c) => c.text)
      .join("\n")
      .slice(0, 1500) ?? JSON.stringify(r).slice(0, 1500);
  return { exa: text(exa), brave: text(brave), google };
};
```

Example, read a page:

```js
async () =>
  codemode.exa_web_fetch_exa({
    urls: ["https://go.dev/doc/devel/release"],
    maxCharacters: 4000,
  });
```

## Sub-agent model selection

When asked something along the lines of "ask gemini for an opinion", "ask gemini for review", "ask grok about this" and so on, you are supposed to spawn a subagent to answer this query. When unsure which model is meant, use `list_agents_and_models`. Decide the reasoning level yourself, for quick questions it's often better to not use `-high` as that significantly increases time.

When calling `spawn_agent`, pick the model by task and pass the exact ID in `model`. Do NOT use any `copilot_chat/*` model, because its quota is limited.

| Task                                                                        | Model                                                                                                                |
| --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Normal coding (most cases)                                                  | `anthropic/claude-opus-5-5`                                                                                          |
| Architecture and design questions                                           | `anthropic/claude-opus-5-5`                                                                                          |
| Well-scoped implementation grunt work                                       | `anthropic/claude-sonnet-5-5`                                                                                        |
| Exploration, codebase search, summarizing logs or test output               | `google/gemini-3.8-flash` or `anthropic/claude-haiku-5-5`                                                            |
| Second opinion or review from a different model family                      | `google/gemini-3.8-flash` or `x_ai_subscribed/grok-4.7`                                                              |
| Proofreading, making text sound more human                                  | `x_ai_subscribed/grok-4.7`                                                                                           |
| Cheap bulk work: many parallel lookups, mechanical edits, simple extraction | zero-retention `opencode/zen/*` free model, else `opencode/go/deepseek-v4.1-flash` or `google/gemini-3.5-flash-lite` |

- Where a row lists two models, prefer the first; use the second if the first is rejected.
- `google/gemini-3.1-pro-preview` is currently unavailable, so don't use it.
- `opencode/go/*`: models change, treat these as guidelines. Prefer cheap flash-tier models. Avoid flagship models (e.g. currently kimi-k3, qwen3.8-max, glm-5.3, gemini-4-argon) because they burn quota fast. If the tier is unknown, treat it as flagship. Never use `opencode/go/grok-4.7`; use `x_ai_subscribed/grok-4.7`.
- `opencode/zen/*` free models are allowed: check https://opencode.ai/v2/docs/console/models/#free-models once per session for each model's data policy, since the list changes. If the page can't be fetched, treat all zen models as data-collecting.
  - Zero-retention, no training: use whenever deemed fit, including private code.
  - Collects or retains data (or no policy listed): only for simple one-off tasks with nothing sensitive in context.
- `spawn_agent` can't set reasoning effort, so the model choice is the only lever.
- If an ID is rejected, run `list_agents_and_models` and pick the closest match from the same provider at the same or lower tier.
- `copilot_chat` can be used for questions that don't require agentic lookup

### Leeway

You may pick any non-flagship `opencode/go/*` or allowed `opencode/zen/*` model yourself when the output will be checked before it matters:

- second opinions, reviews, and devil's-advocate passes
- parallel lookups, extraction, summaries, and drafts you will verify or rewrite
- asking 2-3 different models the same question to compare answers

Do not use off-table models for code that lands in the repo without review.
