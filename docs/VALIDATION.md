# Validation record

Validated on macOS with `herdr-app 0.1.13` against the copied files, using the
showcase directory as `HERDR_APP_HOME`.

All 21 mods passed `herdr-app check`:

```text
my-activity       my-agents        my-chrome       my-goto
my-keys           my-pane          my-prompt       my-settings
my-spaces         my-status        my-tabs         my-usage
my-workspaces     sleek-activity   sleek-chrome    sleek-pane
sleek-status      sleek-tabs       sleek-usage     sleek-workspaces
tmux-prefix
```

The sandboxed check initially stalled before producing a result. It was stopped
and the complete check run passed with desktop access. Generated type/config
files were removed afterwards; they are not part of the package.

Additional checks passed:

- JSON parsing, Python syntax, shell syntax, OpenCode JavaScript syntax.
- Every local Markdown link and layout's personal mod reference resolves.
- Installer against a temporary config: full backup, preserved unrelated file,
  repeat installation, only the intended payload copied, and symlink refusal.
- Claude and Codex prompt/reply hooks with invented input and an isolated HOME.
- Optional Claude usage writer keeps only timestamp/rate limits from test input.
- Source file hashes still match the dotfiles snapshot; dotfiles worktree clean.
- Public payload excludes generated/hidden files, backups, audio, wallpaper
  assets, runtime JSONL, shared state, private home paths, and common token patterns.
- Every retained PNG crop was visually inspected after cropping.

Limits: `check` validates initial rendering, not every deferred row or async
state. The screenshots show the existing live customization, not an installation
of the sanitized copy. A fresh install was exercised as file operations only;
the live user's layout, keys and settings were not replaced. Media permissions,
actual agent hook registration, and restart persistence need a fresh-install
smoke test before release. See [the screenshot checklist](SCREENSHOTS.md) for
the remaining full-view captures.
