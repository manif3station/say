# say

`say` is an isolated Developer Dashboard skill mini project.

## Purpose

Provide a minimal CLI command named `hello` that prints `hello`.

## Layout

- `cli/hello` skill CLI entrypoint
- `lib/Say/Hello.pm` implementation module
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

## Testing

All testing runs inside the shared workspace Docker harness.

