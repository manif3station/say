# 2026-04-20 Skill Purpose Clarification

## Change Type

Documentation clarification

## What Changed

- clarified that `say` is a testing and onboarding skill for Developer Dashboard skills
- reframed the README and usage docs around install, uninstall, CLI dispatch, and browser access
- removed the implication that `say` is meant to be a standalone greeting feature

## Why

`say` exists so new Developer Dashboard users have something concrete to land on when learning what a skill is and how the skill lifecycle works.

## Implementation Alignment

The current implementation supports exactly that scope:

- `dashboard skills install ...`
- `dashboard say.hello`
- `/app/say/hello`
- `dashboard skills uninstall say`
