# say

`say` is an isolated Developer Dashboard skill mini project.

## Purpose

Provide a minimal CLI command named `hello` that prints `hello` and a browser-facing page at `/app/say/hello`.

## Layout

- `cli/hello` skill CLI entrypoint
- `lib/Say/Hello.pm` implementation module
- `lib/Say/Web.pm` DD-style skill page renderer
- `dashboards/hello` DD-style skill page asset
- `t/` skill-local tests
- `.env` skill-local version metadata
- `Changes` skill-local changelog

## Usage

Within the skill repository:

```bash
perl cli/hello
```

Within Developer Dashboard, the installed dotted command form is expected to be:

```bash
dashboard say.hello
```

For the browser-facing skill route, Developer Dashboard's skill app contract is:

```text
/app/say/hello
```

## Testing

All testing runs inside the shared workspace Docker harness.
