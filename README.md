# say

## Description

`say` is an isolated Developer Dashboard skill that adds a minimal greeting capability to the dashboard skill system.

## Value

`say` gives the user a small, clear reference skill that proves both sides of skill delivery:

- CLI command delivery through a skill command entrypoint
- browser page delivery through the DD-style `/app/<skill>/<page>` route contract

It is useful as a baseline for future skills because it shows the smallest practical shape of a working skill without extra moving parts.

## Problem It Solves

When starting a new skill, it is easy to guess at folder layout, route behavior, command structure, and test strategy. That leads to drift and rework.

## What It Does To Solve It

`say` provides:

- a CLI command at `cli/hello`
- a Perl implementation module for the CLI behavior
- a DD-style page asset at `dashboards/hello`
- a web renderer for `/app/say/hello`
- skill-local tests under `t/`
- Docker-only verification including Playwright for the browser-facing page

## Developer Dashboard Feature Added

This skill adds:

- the dotted command usage `dashboard say.hello`
- the DD-style skill page route `/app/say/hello`

## Layout

- `cli/hello` skill CLI entrypoint
- `dashboards/hello` DD-style skill page asset
- `docs/` skill-local documentation
- `lib/Say/Hello.pm` implementation module for the CLI greeting
- `lib/Say/Web.pm` implementation module for the skill page route
- `t/` skill-local tests, including Playwright-backed browser verification
- `.env` skill-local version metadata
- `Changes` skill-local changelog

## Installation

Install the skill through Developer Dashboard from a git repository:

```bash
dashboard skills install <git-url-to-say-skill>
```

Example:

```bash
dashboard skills install https://github.com/example/say.git
```

For local development in this workspace, the skill source is at:

```text
~/projects/skills/skills/say
```

## CLI Usage

Within the skill repository during direct local development:

```bash
perl cli/hello
```

Expected output:

```text
hello
```

Within Developer Dashboard after installation:

```bash
dashboard say.hello
```

Expected output:

```text
hello
```

## Browser Usage

Developer Dashboard skill routes follow the DD pattern:

```text
/app/<skill>/<page>
```

For this skill:

```text
http://127.0.0.1:7890/app/say/hello
```

Expected rendered output:

- page title: `Hello World`
- page heading: `Hello World`

## Practical Examples

Normal case, direct CLI development:

```bash
cd ~/projects/skills/skills/say
perl cli/hello
```

Normal case, installed DD command:

```bash
dashboard say.hello
```

Normal case, browser route:

```text
http://127.0.0.1:7890/app/say/hello
```

## Edge Cases

If the skill is not installed:

- `dashboard say.hello` will not dispatch because DD will not know the skill

If the browser route is wrong:

- `/app/say/missing` should return not found instead of rendering a page

If the dashboard service is not running:

- the browser URL will not load until the DD web service is available

If a future change breaks the browser page:

- the Playwright test in `t/03-hello-page-playwright.t` should fail inside Docker

## Documentation

See:

- `docs/overview.md`
- `docs/usage.md`
- `docs/changes/2026-04-19-doc-gate.md`
- `docs/changes/2026-04-20-document-layout-gate.md`

## Testing

All testing runs inside the shared workspace Docker harness. The skill keeps all tests inside `t/`, and browser-facing verification uses Playwright.
