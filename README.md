# NA29 Islands Rice for Herdr

A riced layout for the [Herdr](https://herdr.dev) desktop app: tmux-style prefix
keybindings, floating islands over your wallpaper, numbered workspaces with their
agents, vim-style navigation, a log of your prompts and the agents' replies, and
15 dark themes. Everything is adjustable from one Settings panel.

![NA29 Islands for Herdr: sidebar with workspaces, agents, activity and usage; fastfetch, cbonsai and btop in see-through panes](docs/hero.png)

<sub>The wallpaper in the screenshots is third-party art and isn't included. The
default background is a gradient; [bring your own](docs/ASSETS.md).</sub>

## Features

**tmux-style keys.** Press the prefix, then a tmux key: `c` new tab, `n`/`p` next
and previous, `%` and `"` to split, `h/j/k/l` to move between panes, `z` to zoom,
`x` to close. Choose your prefix in Settings → Keys: Ctrl+B like tmux, Ctrl+A
(the default), or Ctrl+Space. A cheat sheet pops up while the prefix waits, and
pressing the prefix twice sends it to the program.

**Islands and transparency.** The sidebar, tab strip, panes, status bar and the
Files/Changes panel are separate rounded islands. Islands, cards and panes each
have their own opacity, the wallpaper can be dimmed, and prefix `t` toggles
transparency. Menus stay opaque.

| See-through on | See-through off |
| --- | --- |
| ![Transparency on](docs/transparency-on.png) | ![Transparency off, darkest solid background](docs/transparency-off.png) |

**Settings panel** (Cmd+,). Appearance, wallpaper (image, gradient or solid,
with dim and fit), sidebar, bars, terminal, sounds and keys, all saved to `rice.json`.

| Appearance | Wallpaper |
| --- | --- |
| ![Settings: transparency, accent, theme, corners and gaps](docs/settings.png) | ![Settings: wallpaper folder, dim and fit](docs/wallpaper.png) |

**Themes.** Rosé Pine (default), Rosé Pine Moon, Catppuccin Mocha / Macchiato /
Frappé, Tokyo Night and Storm, Dracula, Gruvbox Dark, Nord, Kanagawa, Everforest
Dark, Solarized Dark, GitHub Dark and One Dark, plus Herdr's Graphite, Ink and
Moss. Terminals, islands, panes and menus follow the theme, and so does the accent
unless you pick another.

**Go to** (Cmd+P). One picker for spaces, tabs, agents and actions. NORMAL mode:
`j/k`, `l`/Enter, `h`, `gg/G`, Ctrl+D/U. Type `/` to search; Esc closes.

| NORMAL | INSERT |
| --- | --- |
| ![Go to in NORMAL mode](docs/goto.png) | ![Go to searching "/fore"](docs/goto-insert.png) |

<img src="docs/workspaces.png" alt="Sidebar" width="260" align="right">

**Sidebar.** Numbered workspaces with their agents, named after each agent's
session everywhere: in the sidebar, the tab bar and Go to. Ctrl+1–9 jumps to a
workspace. Below them: the latest agent runs and your Claude Code / Codex usage
limits (5-hour and 7-day, with reset countdowns).

**Activity log** (prefix `a`). One entry per agent run, with status filters and
search. Enter expands a run to show your prompt and the reply; `y` copies the
prompt, `l` opens the tab.

**Status bar.** CPU, memory, battery, now playing (Spotify or Music, with
controls), Wispr Flow stats and the clock. Each item can be turned off.

<br clear="right">

| Prefix menu | Activity log |
| --- | --- |
| ![Prefix menu](docs/prefix.png) | ![Activity log with a run expanded](docs/activity.png) |

![CPU, memory and battery](docs/status.png)
![Now playing](docs/now-playing.png)
![Wispr Flow stats](docs/wispr.png)

## Requirements

- macOS and [Herdr](https://herdr.dev) (tested on 0.1.13), with `herdr-app` and `hc` on PATH.
- `python3` (standard library only). Fonts come with Herdr.
- Optional: Spotify or Music, Wispr Flow, Claude Code, Codex, OpenCode, and
  `ffmpeg` to use a macOS alert sound.

The mods run local helpers (`python3`, `git`, `hc`, `osascript`, system metrics)
and read local agent logs and Wispr's database. They make no network requests of
their own. Review the code before installing.

## Install

Open Herdr once, quit it, then:

```sh
git clone https://github.com/NA29/na29s-islands.git
cd na29s-islands
./install.sh
```

The installer backs up your whole `~/.config/herdr-app` to a sibling
`herdr-app-backup-*` folder first, then copies `layouts/`, `mods/`, `themes/`,
`keys.json`, `rice.json` and `settings.json`. It never deletes files and refuses
symlinked destinations (copy a Stow-managed config to a real folder first). Your
keys and settings are replaced; the backup has them.

Open Herdr and switch to the layout:

```sh
herdr-app do layout.switch --name na29-islands
```

<details>
<summary>Manual install</summary>

With Herdr closed:

```sh
backup=$(mktemp -d "$HOME/.config/herdr-app-backup-XXXXXX")
[ -d "$HOME/.config/herdr-app" ] && cp -pR "$HOME/.config/herdr-app" "$backup/config"
mkdir -p "$HOME/.config/herdr-app"
cp -pR layouts mods themes licenses "$HOME/.config/herdr-app/"
cp -p keys.json rice.json settings.json LICENSE NOTICE THIRD_PARTY.md "$HOME/.config/herdr-app/"
```

To install only part of it, copy the layout and the mods it uses, merge the keys
and settings, and check for existing `my-*`, `sleek-*` or `tmux-prefix` mods first.
`my-combined` and `my-main` are two alternative layouts.
</details>

### Optional: activity hooks

The Activity log shows prompts and replies only if your agents report them.
Back up each config, then merge (don't replace) these entries:

| Agent | Merge | Into |
| --- | --- | --- |
| Claude Code | [hooks.json](integrations/claude/hooks.json) | `~/.claude/settings.json` |
| Codex | [hooks.json](integrations/codex/hooks.json) | `~/.codex/hooks.json`, with `hooks = true` under `[features]` in `~/.codex/config.toml` |
| OpenCode | copy [herdr-app-status.js](integrations/opencode/herdr-app-status.js) to `~/.config/opencode/` | add `"./herdr-app-status.js"` to `plugin` in `tui.jsonc` |

Restart the agent and trust the new hooks when asked. OpenCode 2.x reports
status only, not prompt text. Records stay local in `~/.cache/herdr-activity/`
(60 per terminal, prompts cut at 4,000 characters).

### Optional: Claude usage

Codex usage is read from its local session logs. For Claude, the usage card needs
a small status-line helper: see [integrations/claude](integrations/claude/README.md).

## Keys

`Prefix → x` means press your prefix key (Ctrl+A by default), release, then press `x`.

| Key | Action |
| --- | --- |
| Cmd+P / Cmd+, | Go to / Settings |
| Cmd+N / Cmd+T | New workspace (named) / new tab |
| Ctrl+1–9 / Cmd+1–9 | Workspace / tab by number |
| Cmd+Option+[ / ] · Ctrl+Tab | Previous / next workspace · next tab |
| Cmd+D / Cmd+Shift+D | Split right / down |
| Ctrl+H/J/K/L | Move between panes (passed to the terminal at an edge) |
| Cmd+Shift+Enter · Cmd+W | Zoom pane · close tab |
| Cmd+B · Cmd+Shift+L | Toggle sidebar · cycle layouts |
| Prefix → `g` / `s` / `a` | Go to / Settings / Activity log |
| Prefix → `c` `n` `p` | New / next / previous tab |
| Prefix → `%` `"` `z` `x` | Split right / down, zoom, close pane |
| Prefix → `J` / `K` | Next / previous workspace (repeatable) |
| Prefix → `t` / `b` / `?` | Transparency / sidebar / all bindings |

The prefix (Ctrl+A, Ctrl+B or Ctrl+Space) and Ctrl+H/J/K/L can be changed or turned
off in Settings → Keys.

## Customize

Use **Settings**: it writes `rice.json` and applies the look to
`layouts/na29-islands.json` and the keys to `keys.json`. To edit `rice.json` by
hand, quit Herdr first. Herdr's own preferences (zoom, sounds) stay in
`settings.json`. [RECIPE.md](RECIPE.md) describes how the layout is built.

## Uninstall

Run `herdr-app do layout.switch --name main` and quit Herdr. Then move your config
aside and restore the backup the installer printed:

```sh
mv "$HOME/.config/herdr-app" "$HOME/.config/herdr-app-na29-islands"
cp -pR /path/to/herdr-app-backup-XXXXXX/config "$HOME/.config/herdr-app"
```

Remove any hook entries you added. Local activity records in
`~/.cache/herdr-activity/` aren't removed automatically.

## Credits

Built on [Herdr](https://herdr.dev), with [Rosé Pine](https://rosepinetheme.com)
as the default theme and [Geist](https://vercel.com/font) type. Theme palettes
come from their original projects. Licensed under [Apache-2.0](LICENSE); see
[THIRD_PARTY.md](THIRD_PARTY.md) for credits and upstream licenses.
