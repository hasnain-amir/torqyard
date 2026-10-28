# Contributing

## Development workflow

All changes must be associated with a defined implementation task.

1. Confirm the task scope and acceptance criteria.
2. Create a branch from the current main branch,
3. Implement a small, focused change.
4. Run applicable verification checks.
5. Review the results and resolve failures.
6. Commit the verified changes.
7. Open a pull request for review.
8. Merge only after explicit approval.

Do not commit unverified implementation changes.

## Branch naming

Use descriptive prefixes:

- `feat/` for new functionality.
- `fix/` for defect corrections.
- `test/` for test additions or corrections.
- `docs/` for documentation.
- `chore/` for maintenance and tooling.
- `ci/` for continuous integration.

## Commit messages

Use Conventional Commits.

Examples:

- `chore: establish project foundation`
- `feat: add vehicle creation`
- `fix: enforce vehicle privacy`
- `test: cover garage access permissions`
- `docs: document local development`

Commits must describe changes accurately.

## Code quality

- Prefer simple, maintainable implementations.
- Follow supported upstream extension interfaces.
- Avoid unnecessary dependencies.
- Validate untrusted input.
- Enforce authorisation server-side.
- Keep secrets outside version control.
- Including meaningful tests for new functionality.
- Document architectural decisions when necessary.

## Verification

Before requesting review, run the checks applicable to the changed files.

These may include:

- Formatting.
- Linting.
- Type checking.
- Unit and integration tests.
- Security and permissions tests.
- Application builds.
- Manual function verification.

Exact commands will be documented as tooling is introduced.

Never report a check as passing unless it has actually been executed successfully.

## Approval

Repository merges, significant architectural changes and production deployments require explicit product-owner approval.
