mkdir -p docs/spikes

cat > docs/spikes/nodebb-postgresql.md <<'EOF'

# NodeBB and PostgreSQL Feasibility Spike

## Status

Passed.

## Platform

- Product: TorqYard
- NodeBB: v4.16.2
- Upstream revision: 66c3f49ade1965aabee165f205f6b73eaf71088a
- Node.js: v24.15.0
- PostgreSQL: 18.4
- Local email testing: Mailpit

## Verified Behaviour

- NodeBB starts successfully using PostgreSQL.
- The administrator can authenticate using local credentials.
- Administrator email verification works with Mailpit.
- A published discussion survives a NodeBB application restart.
- The persisted discussion retains its title and body.

## Reproduction Notes

- Development services are defined in `infra/development/compose.yaml`.
- Environment variable examples are in `infra/development/.env.example`.
- The upstream NodeBB checkout is excluded from this repository.
- Runtime configuration and real development credentials must remain untracked.

## Outstanding Work

- Establish a reproducible upstream NodeBB installation process.
- Correct legacy infrastructure identifiers without losing PostgreSQL data.
- Complete automated integration and persistence tests.
- Review authentication and email behaviour for production deployment.
  EOF
