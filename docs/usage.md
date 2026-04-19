# say Usage

## Install

Install with Developer Dashboard:

```bash
dashboard skills install <git-url-to-say-skill>
```

Example:

```bash
dashboard skills install https://github.com/example/say.git
```

## CLI

Direct local development:

```bash
cd ~/projects/skills/skills/say
perl cli/hello
```

Installed DD usage:

```bash
dashboard say.hello
```

Expected result:

```text
hello
```

This proves that an installed skill can expose a CLI command through DD.

## Browser

Expected route:

```text
http://127.0.0.1:7890/app/say/hello
```

Expected result:

- HTML title is `Hello World`
- visible `h1` is `Hello World`

This proves that an installed skill can expose a browser page through DD.

## Uninstall

Remove the skill after testing:

```bash
dashboard skills uninstall say
```

This proves that the installed skill lifecycle can be reversed cleanly.

## Edge Cases

- `/app/say/missing` should not render a page
- if DD is not running, the browser page will not load
- if the skill is not installed, dotted command dispatch will fail
- if the skill is uninstalled, both CLI and browser access should disappear

