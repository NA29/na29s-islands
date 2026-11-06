# Credits and provenance

- [Herdr](https://herdr.dev): desktop app, gpui-kit integration, shipped layout
  and mod foundations, and icons in cloned mods. `cloned_from` metadata is
  retained where present.
- [tmux-prefix by herdrdev](https://herdr.dev/mods/herdrdev/tmux-prefix): the
  starting point for the prefix overlay, with personal navigation and settings.
- [Rosé Pine](https://rosepinetheme.com): the palette used by `themes/rose-pine.json`.
- [Geist](https://vercel.com/font): words in Geist, numbers and keycaps in Geist
  Mono. Herdr supplies the fonts; font files are not redistributed here.
- JetBrains Mono: Herdr's default terminal font.

Source snapshot: the personal dotfiles `stow-layout` branch, commit `3812250`.
Publication changes: gradient defaults in the layout, rice settings and both
Settings default maps; generic wallpaper folder; default notification sounds;
one generic example substituted in a source comment. The original main layout
is published as `layouts/na29-islands.json` (NA29 Islands); the settings writer
and installation instructions use that name. The OpenCode integration
is copied from the same dotfiles snapshot.

## Licenses

The original customization is licensed under **Apache-2.0**, copyright 2026 NA29;
see [LICENSE](LICENSE) and [NOTICE](NOTICE). This matches the licenses of
[Herdr](https://github.com/herdrdev/herdr-app/blob/master/LICENSE) and
[its layout examples](https://github.com/herdrdev/herdr-layout-examples/blob/main/LICENSE).
The personal mod entry points carry modification notices, and layout files retain
their `cloned_from` metadata. Existing upstream rights and notices are preserved.

Included SVG icons from Lucide/Feather retain their ISC/MIT terms; their complete
[license notices](licenses/lucide-feather.txt) are included. Herdr's upstream
third-party notices identify Lucide/Feather icons in its shipped mods.
The Rosé Pine palette retains its [MIT license](licenses/rose-pine.txt).

Geist, Geist Mono and JetBrains Mono are runtime font references; no font files
are redistributed. Herdr's brand and program images are also runtime references
provided by the installed app. License texts were obtained from the upstream
repositories on 2026-11-06. Attribution does not imply endorsement.
