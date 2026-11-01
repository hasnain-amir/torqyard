# TorqYard

**A modern automotive community for UK car and motorcycle enthusiasts.**

TorqYard is being developed as a dedicated platform for automotive discussions, vehicle garages, build journals, clubs, meets, events and community interaction.

> **Project status:** In development. Not yet available to the public.

## Development Progress

**Current phase:** Phase 1 - Testing and Quality Assurance

**Currently working on:** Final review and merge of automated security and PostgreSQL integration tests (PR #3).

### Completed

- [x] GitHub repository and protected development workflow
- [x] NodeBB v4.16.2 installation
- [x] PostgreSQL 18.4 integration
- [x] Docker Compose development infrastructure
- [x] Local email testing with Mailpit
- [x] Administrator authentication and email verification
- [x] Forum discussion persistence testing
- [x] Reproducible development setup and feasibility verification
- [x] Infrastructure foundation merged (PR #1)
- [x] Automated repository quality checks with GitHub Actions (PR #2)
- [x] Automated secret scanning with Gitleaks
- [x] Isolated PostgreSQL integration tests
- [x] Integration test failure detection and container cleanup verified

### In Progress

- [ ] Complete PR #3 review and merge

### Next

- [ ] Introduce NodeBB-specific automated integration tests
- [ ] Begin the Carbon Amber design system and custom NodeBB theme
- [ ] Develop vehicle garages, build journals and community features

## Technology

| Component                  | Technology      |
| -------------------------- | --------------- |
| Community platform         | NodeBB v4.16.2  |
| Database                   | PostgreSQL 18.4 |
| Runtime                    | Node.js 24      |
| Development infrastructure | Docker Compose  |
| Local email testing        | Mailpit         |
| Automated testing          | GitHub Actions  |
| Security scanning          | Gitleaks        |

Custom functionality will be developed using supported NodeBB plugins and theme extensions.

## Documentation

- [Product Requirements](docs/torqyard_PRD_v1.md)
- [Local Development Setup](docs/development/local-setup.md)
- [Technical Feasibility Report](docs/spikes/nodebb-postgresql.md)
- [Contribution Guidelines](CONTRIBUTING.md)

## Following Development

TorqYard's co-owners can follow progress through this README and the repository's [commits](https://github.com/hasnain-amir/torqyard/commits), [branches](https://github.com/hasnain-amir/torqyard/branches) and [pull requests](https://github.com/hasnain-amir/torqyard/pulls).

Development follows a feature-branch workflow. Changes are reviewed and verified before merging into the protected `main` branch.

---

_TorqYard is in early development. Planned features and timelines are subject to technical feasibility and implementation progress._
