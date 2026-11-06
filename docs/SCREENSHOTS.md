# Screenshot provenance and retakes

All images came from `herdr-app shot` on Herdr 0.1.13. The raw frames were
inspected, then cropped with macOS `sips`; only reviewed crops are in this repo.
Raw frames contain private terminal/agent content and are not committed.
No names or conversations were replaced with fabricated content.

| File | What is visible | Publication status |
| --- | --- | --- |
| `hero.png`, root `preview.png` | Prefix menu, same crop as `prefix.png` | Safe temporary preview; replace with a full layout capture |
| `prefix.png` | Entire menu interior | Reviewed |
| `settings.png` | Appearance panel interior | Reviewed; live values differ from shipped defaults |
| `transparency.png` | Islands/cards/panes controls | Reviewed |
| `goto.png` | NORMAL mode header/search field | Reviewed; full picker and INSERT mode need retakes |
| `workspaces.png` | A single workspace number, no name | Reviewed; full sidebar needs a retake |
| `activity.png` | Summary counters and status filters only | Reviewed; expanded prompt/reply needs a retake |
| `status.png` | CPU, memory, battery | Reviewed |
| `now-playing.png` | Track/artist/progress/transport | Reviewed; review whether you want listening activity public |
| `wispr.png` | Dictations, words, speaking time | Reviewed; numeric statistics only |
| `usage.png` | Provider labels, plan label, percentages, resets | Reviewed; review whether you want plan/usage figures public |

The small translucent status/usage crops contain background shading from the
live setup. They do not include the wallpaper as a standalone asset or a
recognizable scene. For a uniformly gradient-only showcase, retake these too.

## Retake before the full showcase/listing

1. **Hero / islands / preview:** use a gradient or art you own, generic workspace
   and tab names, and clean sample terminal output. Capture the full window
   with no overlay. Save as `docs/hero.png` and copy it to root `preview.png`.
2. **Numbered workspaces:** crop the complete sidebar showing generic names and
   sample agent titles; replace `docs/workspaces.png`.
3. **Go to:** capture the full picker in NORMAL and INSERT modes using a harmless
   query, generic workspaces and tabs. Replace `docs/goto.png` and add an INSERT
   image to the README.
4. **Activity:** run a harmless sample prompt (for example, explain a tiny demo
   function), filter to it, and expand it so both prompt and reply appear.
   Check workspace names, titles, paths, counters and surrounding panes too.
   Replace `docs/activity.png`.
5. **Wallpaper/dim:** show the Wallpaper panel with an empty or licensed image
   folder, gradient swatches and Dim control. Do not show third-party thumbnails
   or personal file paths. Add the capture to the wallpaper tour section.

After replacing images, update README captions and remove the temporary-preview
notes in README and RECIPE. Do not stage raw full-window shots by accident.

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
