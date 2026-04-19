# Testing

## Policy

- tests run only inside Docker
- the shared test container definition lives at the workspace root
- this skill keeps its test files in `t/`

## Commands

```bash
docker compose -f /home/mv/projects/skills/docker-compose.testing.yml run --rm perl-test bash -lc 'cd /workspace/skills/say && prove -lr t'
docker compose -f /home/mv/projects/skills/docker-compose.testing.yml run --rm perl-test bash -lc 'cd /workspace/skills/say && cover -delete && HARNESS_PERL_SWITCHES=-MDevel::Cover prove -lr t && cover -report text -select_re "^lib/" -coverage statement -coverage subroutine'
```

## Latest Verification

- Date: 2026-04-19
- Functional and browser test:
  - `docker compose -f /home/mv/projects/skills/docker-compose.testing.yml run --rm perl-test bash -lc 'cd /workspace/skills/say && prove -lr t'`
  - Result: pass
  - Includes: Playwright verification of `/app/say/hello`
- Coverage test:
  - `docker compose -f /home/mv/projects/skills/docker-compose.testing.yml run --rm perl-test bash -lc 'cd /workspace/skills/say && cover -delete && HARNESS_PERL_SWITCHES=-MDevel::Cover prove -lr t && cover -report text -select_re "^lib/" -coverage statement -coverage subroutine'`
  - Result: pass
  - Coverage: `100.0%` statement and `100.0%` subroutine for `lib/Say/Hello.pm` and `lib/Say/Web.pm`
- Cleanup:
  - `docker compose -f /home/mv/projects/skills/docker-compose.testing.yml run --rm perl-test bash -lc 'rm -rf /workspace/skills/say/cover_db'`
  - Result: pass
