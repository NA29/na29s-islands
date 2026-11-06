# Claude usage card

Activity hooks collect prompts and replies, not rate limits. The usage card
reads a separate local snapshot produced from Claude's status-line JSON input.
The small [usage-statusline.py](usage-statusline.py) helper writes only the
`rate_limits` object and a timestamp, then prints the model name as a minimal
status line. It does not call a usage API or require `jq`.

After backing up any existing file at the destination:

```sh
mkdir -p "$HOME/.config/herdr-app/integrations"
cp integrations/claude/usage-statusline.py "$HOME/.config/herdr-app/integrations/"
```

If you do not already have a custom status line, merge this property into
`~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "python3 -I \"$HOME/.config/herdr-app/integrations/usage-statusline.py\""
  }
}
```

If you already have a status line, keep it. Save stdin once in that script,
feed the same JSON to this helper with its stdout redirected to `/dev/null`,
and render your normal output from the saved JSON. For a shell wrapper, the
pattern is:

```sh
input=$(cat)
printf '%s' "$input" | python3 -I "$HOME/.config/herdr-app/integrations/usage-statusline.py" >/dev/null
printf '%s' "$input" | /path/to/your-existing-statusline
```

Do not point the last line back to the wrapper itself. The integration depends
on Claude supplying `rate_limits.five_hour` and `rate_limits.seven_day`; when
absent, the helper leaves the previous snapshot intact. Herdr hides stale
providers in `recent` mode and labels older readings. To uninstall, restore
your previous `statusLine` setting or remove just the helper invocation.
