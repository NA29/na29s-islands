# Screenshot provenance

All images came from `herdr-app shot` on Herdr 0.1.13. Raw frames were
inspected, then cropped or resized with macOS `sips`; only reviewed images are in
this repo. Raw frames are not committed.

The full-window shots use a demo scene: workspaces `rice`, `aurora` and
`dotfiles`, sample tabs, `fastfetch`/`cbonsai`/`btop` output, and three harmless
sample agent prompts about a tiny demo file (`forecast.js`). The prompts,
replies and agent titles in the images are real output from those sample runs;
nothing was edited afterwards. The wallpaper is third-party anime art chosen by
the author; it is **not** distributed here (see [ASSETS.md](ASSETS.md)).

| File | What is visible |
| --- | --- |
| `hero.png`, root `preview.png` | Full window, transparency on, no overlay |
| `transparency-on.png` / `transparency-off.png` | The same frame with see-through on and off |
| `workspaces.png` | Full sidebar: numbered workspaces, demo agents, activity and usage cards |
| `goto.png` | Go to in NORMAL mode, full picker |
| `goto-insert.png` | Go to in INSERT mode, filtered by `/fore` |
| `activity.png` | Activity log with a sample run expanded (prompt and reply) |
| `wallpaper.png` | Settings → Wallpaper: folder, Dim slider, Fill/Fit |
| `settings.png` | Settings → Appearance: transparency, colour, theme and shape controls |
| `prefix.png` | Ctrl+A prefix menu |
| `status.png`, `now-playing.png`, `wispr.png`, `usage.png` | Status-bar and usage crops from an earlier frame |

Values in the images (opacity, dim, gap) reflect the live setup at capture
time; the installable defaults come from the clean config snapshot.

## Safe capture procedure

```sh
herdr-app status
herdr-app shot /tmp/herdr-review.png
```

Inspect `overlays` before opening anything. If the intended overlay is already
open, do not toggle it (the command would close it). Record the initial stack:

```sh
herdr-app do mod.open --name my-goto
# Or: tmux-prefix / my-settings
herdr-app shot /tmp/herdr-overlay-review.png
herdr-app status
# Only if the stack is unchanged apart from YOUR newly opened top overlay:
herdr-app do overlay.close
```

For Activity, use Ctrl+A then `a`. Never close another person's overlay to get
a cleaner shot. Inspect the final cropped PNG, not only the raw frame; cropping
can leave a sliver of terminal text or a personal name at the edge. Keep raw
captures outside the checkout and copy only approved images into `docs/`.
