# say

## Description

`say` is an isolated Developer Dashboard skill for testing and demonstrating the Developer Dashboard skill system. It exists so a new user has a real skill to land on when first exploring what skills are, how they are installed, how they are uninstalled, how skill CLI commands run, and how skill browser pages work.

## Value

`say` gives the user a small, clear reference skill that proves both sides of skill delivery:

- CLI command delivery through a skill command entrypoint
- browser page delivery through the DD-style `/app/<skill>/<page>` route contract

It is intentionally simple because its purpose is framework testing and first-use onboarding. Nothing more and nothing less.

## Problem It Solves

When someone first encounters Developer Dashboard, a skill can otherwise remain abstract. Users need something concrete they can install, run, browse, and remove so they can understand how the skill system behaves in practice.

## What It Does To Solve It

`say` provides:

- an installable and removable example skill
- a CLI command at `cli/hello`
- a Perl implementation module for the CLI behavior
- a DD-style page asset at `dashboards/hello`
- a web renderer for `/app/say/hello`
- skill-local tests under `t/`
- Docker-only verification including Playwright for the browser-facing page

## Developer Dashboard Feature Added

This skill adds:

- a safe first skill to install and uninstall while learning DD skills
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

This command is intentionally minimal. Its purpose is to prove that DD skill CLI dispatch works.

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

This page is intentionally minimal. Its purpose is to prove that DD skill browser routing works.

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

Normal case, install the skill:

```bash
dashboard skills install https://github.com/example/say.git
```

Normal case, browser route:

```text
http://127.0.0.1:7890/app/say/hello
```

Normal case, uninstall after trying it:

```bash
dashboard skills uninstall say
```

## Edge Cases

If the skill is not installed:

- `dashboard say.hello` will not dispatch because DD will not know the skill

If the skill has been uninstalled:

- `/app/say/hello` should no longer be available through Developer Dashboard

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
- `docs/changes/2026-04-20-skill-purpose-clarification.md`
- `docs/changes/2026-04-19-doc-gate.md`
- `docs/changes/2026-04-20-document-layout-gate.md`

## Testing

All testing runs inside the shared workspace Docker harness. The skill keeps all tests inside `t/`, and browser-facing verification uses Playwright.
