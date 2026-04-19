# say Usage

## Install

Install with Developer Dashboard:

```bash
dashboard skills install <git-url-to-say-skill>
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

## Browser

Expected route:

```text
http://127.0.0.1:7890/app/say/hello
```

Expected result:

- HTML title is `Hello World`
- visible `h1` is `Hello World`

## Edge Cases

- `/app/say/missing` should not render a page
- if DD is not running, the browser page will not load
- if the skill is not installed, dotted command dispatch will fail

