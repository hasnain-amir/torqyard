# NodeBB and PostgreSQL Feasibility Spike

## Status

Passed: manual feasibility verification.

## Platform

- Product: TorqYard
- NodeBB: v4.16.2
- Upstream revision: 66c3f49ade1965aabee165f205f6b73eaf71088a
- Node.js: v24.15.0
- PostgreSQL: 18.4
- Local email testing: Mailpit

## Verified Behaviour

- NodeBB starts successfully using PostgreSQL.
- Administrator authentication succeeds using local credentials.
- SMTP email delivery and administrator email verification work through Mailpit.
- A published discussion survives a NodeBB application restart.
- The persisted discussion retains its title and body.
- The Docker Compose project was renamed without losing the existing PostgreSQL data.
- The application starts from the renamed local project directory.

## Development Infrastructure

- Compose configuration: `infra/development/compose.yaml`
- Environment template: `infra/development/.env.example`
- Compose project: `torqyard`
- PostgreSQL database: `torqueyard`
- PostgreSQL user: `torqueyard`
- Existing persistent volume: `torqueyard_postgres_data`

The legacy PostgreSQL identifiers are retained deliberately to preserve the existing development database.

The Compose configuration references the existing PostgreSQL volume as an external volume.

The upstream NodeBB checkout, runtime configuration, database credentials and local database backups remain excluded from Git.

## Known Issues

- The Web Push plugin rejects the local HTTP URL as its VAPID subject. This is nonfatal during startup.
- NodeBB reports a potential compatibility issue with `nodebb-plugin-emoji-android`.
- The initial administrator authentication setup required troubleshooting. Authentication was subsequently verified.
- Automated integration and persistence tests have not yet been implemented.

## Outstanding Work

- Document a reproducible NodeBB installation pinned to the verified upstream revision.
- Establish automated integration and persistence tests.
- Implement project-specific functionality through supported NodeBB extensions.
- Review authentication, email delivery, plugin compatibility and Web Push configuration for production.
- Complete production infrastructure and deployment validation.

## Conclusion

NodeBB v4.16.2 with PostgreSQL 18.4 is feasible as the local development foundation for TorqYard.

This result does not establish production readiness or validate the feasibility of every feature in the product requirements.
