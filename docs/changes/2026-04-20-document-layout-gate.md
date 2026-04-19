# 2026-04-20 Document Layout Gate Update

## Change Type

Documentation and repository-layout alignment

## What Changed

- moved project-management markdown files out of the skill root and into `tickets/`
- normalized skill documentation to use `~/...` for home-directory paths
- kept the `say` root focused on implementation essentials plus top-level skill metadata

## Why

The workspace document gate now requires:

- normal skill documentation under `docs/`
- project-management markdown under `tickets/`
- home-directory paths written as `~/...`

## Implementation Alignment

The skill layout after this update keeps:

- implementation in `cli/`, `lib/`, and `dashboards/`
- tests in `t/`
- end-user and maintainer docs in `docs/`
- ticket and project-management records in `tickets/`

