# TorqYard Platform
A UK-focused automotive community platform for car and motorcycle enthusiasts.

The platform combines traditional chronological discussions with member vehicle garages, build journals, automotive discovery and community features.

## Project status

Phase 0: Technical foundation and feasibility assessment.

The application architecture and infrastructure are subject to feasibility testing. No production deployment has been established.

## Technical direction

The proposed foundation consists of:

- NodeBB for the forum and community core.
- PostgreSQL, subject to integration testing.
- Modular NodeBB plugins for custom platform functionality.
- A custom theme based on supported NodeBB extension points.
- TypeScript for project-owned code where appropriate.
- Docker for reproducible local infrastructure.

Technology selections remain provisional until the relevant feasibility assessment pass.

## Requirements

The product requirements are documented in:
- `docs/torqyard_PRD_v1.md`
- `docs/torqyard_PRD_v1.docx`

The Markdown document is the development reference. The approved PRD remains authoritative.

## Development

Development follows a feature-branch workflow with focused changes, automated verification and reviewed pull requests.

See [CONTRIBUTING.md](CONTRIBUTING.md) for development conventions.

## Current limitations

NodeBB v4.16.2 has been installed and manually integration-tested against PostgreSQL 18.4.

The feasibility spike confirmed administrator authentication, email verification through Mailpit, and discussion persistence after an application restart.

The upstream NodeBB checkout remains excluded from Git. Reproducible installation instructions, automated integration tests, project-specific functionality, and production deployment infrastructure have not yet been completed.

See [the NodeBB/PostgreSQL feasibility report](docs/spikes/nodebb-postgresql.md) for the results and outstanding work.
