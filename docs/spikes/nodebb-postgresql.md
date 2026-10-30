# NodeBB and PostgreSQL Feasibility Spike

## Status

**Passed — Manual feasibility and clean-installation verification.**

NodeBB v4.16.2 with PostgreSQL 18.4 has been validated as the local development foundation for TorqYard.

## Platform

| Component                | Version                                    |
| ------------------------ | ------------------------------------------ |
| Product                  | TorqYard                                   |
| NodeBB                   | v4.16.2                                    |
| NodeBB upstream revision | `66c3f49ade1965aabee165f205f6b73eaf71088a` |
| Node.js                  | v24.15.0                                   |
| PostgreSQL               | 18.4                                       |
| Local email testing      | Mailpit                                    |
| Infrastructure           | Docker Compose                             |

## Verified Behaviour

The original development environment successfully demonstrated:

- NodeBB installation, startup and PostgreSQL connectivity.
- Administrator authentication using local credentials.
- SMTP email delivery and administrator email verification through Mailpit.
- Discussion creation and persistence after an application restart.
- Successful migration of the Docker Compose project name without losing PostgreSQL data.
- Successful application startup after renaming the local project directory.

## Clean Installation Acceptance Test

**Status: Passed**

A separate installation was created using the documented development setup procedure.

The isolated environment used:

- A fresh checkout of NodeBB at the pinned upstream revision.
- A new PostgreSQL 18.4 database and dedicated Docker volume.
- NodeBB running on `http://127.0.0.1:4568`.
- PostgreSQL exposed locally on port `55433`.
- A separate administrator account.

The following acceptance criteria were verified:

| Acceptance criterion                             | Result |
| ------------------------------------------------ | ------ |
| Pinned upstream checkout succeeds                | Passed |
| Existing checkout overwrite protection works     | Passed |
| Fresh PostgreSQL instance starts successfully    | Passed |
| NodeBB setup completes against the new database  | Passed |
| NodeBB builds and starts                         | Passed |
| Administrator authentication succeeds            | Passed |
| Discussion can be created and published          | Passed |
| Discussion survives a NodeBB restart             | Passed |
| Original development instance remains accessible | Passed |

The original application continued responding on port `4567` while the isolated instance responded on port `4568`.

The clean-installation test confirms reproducibility on the tested macOS development environment. It does not establish cross-platform or production compatibility.

## Development Infrastructure

The development environment is maintained through:

- `infra/development/compose.yaml` — PostgreSQL and Mailpit services.
- `infra/development/.env.example` — environment variable template.
- `infra/nodebb/upstream.env` — pinned NodeBB release and revision.
- `infra/nodebb/checkout.sh` — upstream checkout procedure.
- `docs/development/local-setup.md` — installation and configuration instructions.

### PostgreSQL Volume Configuration

Fresh installations use the Docker-managed volume:

`torqyard_postgres_data`

The original development environment retains its existing volume:

`torqueyard_postgres_data`

A local, Git-ignored Compose override maps the existing volume into the renamed Compose project.

The original PostgreSQL database and user retain the internal identifier `torqueyard`. These identifiers are intentionally preserved and do not affect the public product identity.

Runtime configuration, database credentials, local Compose overrides and database backups are excluded from version control.

## Known Issues and Limitations

- NodeBB's Web Push plugin reports a nonfatal VAPID subject error when using the local HTTP development URL.
- NodeBB reports a potential compatibility warning for `nodebb-plugin-emoji-android`.
- Automated integration, persistence and end-to-end tests have not yet been implemented.
- Installation reproducibility has been verified on macOS, but not on other operating systems.
- The platform has not undergone production security, performance or operational readiness testing.

## Outstanding Work

- Establish automated integration and persistence tests.
- Implement continuous integration and required quality checks.
- Develop TorqYard-specific functionality using supported NodeBB plugins and theme extensions.
- Evaluate and address plugin compatibility warnings.
- Review authentication, email delivery and Web Push configuration for production.
- Complete production infrastructure, security hardening, monitoring and deployment validation.

## Conclusion

**The NodeBB v4.16.2 and PostgreSQL 18.4 feasibility spike has passed its manual acceptance criteria.**

The results establish a working, reproducible local development foundation for TorqYard.

The technical foundation is suitable for progressing into subsequent implementation work, subject to the remaining engineering requirements and feature-specific feasibility assessments.

This result does not establish production readiness or confirm the feasibility of every feature defined in the Product Requirements Document.
