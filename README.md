# TorqYard

**A modern automotive community for UK car and motorcycle enthusiasts.**

TorqYard is being developed as a dedicated platform for automotive discussions, vehicle garages, build journals, clubs, meets, events and community interaction.

> **Project status:** In development. Not yet available to the public.

## Development Progress

**Current phase:** Phase 0 - Technical Foundation

**Currently working on:** Final validation of the reproducible NodeBB development environment.

### Completed

- [x] GitHub repository and development workflow
- [x] NodeBB v4.16.2 installation
- [x] PostgreSQL 18.4 integration
- [x] Docker Compose development infrastructure
- [x] Local email testing with Mailpit
- [x] Administrator authentication and email verification
- [x] Forum discussion persistence testing
- [x] Repository security checks and branch protection

### In Progress

- [ ] Complete reproducible development setup
- [ ] Finalise feasibility testing and documentation
- [ ] Review and merge the infrastructure pull request

### Next

- [ ] Establish automated tests and CI
- [ ] Begin the TorqYard custom theme and design system
- [ ] Develop platform-specific community features

## Technology

| Component                  | Technology      |
| -------------------------- | --------------- |
| Community platform         | NodeBB v4.16.2  |
| Database                   | PostgreSQL 18.4 |
| Runtime                    | Node.js 24      |
| Development infrastructure | Docker Compose  |
| Local email testing        | Mailpit         |

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
