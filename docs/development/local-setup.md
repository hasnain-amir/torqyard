# Local Development Setup

This guide describes the local development environment for TorqYard.

## Prerequisites

- macOS or a compatible Linux development environment
- Git
- Docker with Docker Compose
- Node.js v24.15.0, preferably managed with nvm
- npm

The repository contains `.nvmrc` to specify the Node.js version.

## 1. Clone TorqYard

```bash
git clone https://github.com/hasnain-amir/torqyard.git
cd torqyard
nvm install
nvm use
```

## 2. Configure development environment

```bash
cp infra/development/.env.example infra/development/.env
```

Edit `infra/development/.env` and replace the placeholder database password with a unique local password.

Never commit this file.

## 3. Start PostgreSQL and Mailpit

For a new installation:

```bash
docker compose -f infra/development/compose.yaml up -d
docker compose -f infra/development/compose.yaml ps
```

The default configuration creates a PostgreSQL volume managed by Docker Compose.

Local service endpoints:

- PostgreSQL: `127.0.0.1:55432`
- Mailpit SMTP: `127.0.0.1:1025`
- Mailpit interface: http://127.0.0.1:8025

## 4. Checkout the pinned NodeBB revision

```bash
bash infra/nodebb/checkout.sh
```

The checkout is pinned to NodeBB v4.16.2 at commit
`66c3f49ade1965aabee165f205f6b73eaf71088a`.

The checkout is created under `vendor/nodebb`, which is excluded from Git.

The script refuses to overwrite an existing checkout.

## 5. Install and configure NodeBB

```bash
cd vendor/nodebb
./nodebb setup
```

During setup, configure:

- URL: `http://127.0.0.1:4567`
- Database: PostgreSQL
- Host: `127.0.0.1`
- Port: `55432`
- Database: the `POSTGRES_DB` value from your local environment file
- Username: the `POSTGRES_USER` value
- Password: the `POSTGRES_PASSWORD` value

Create an administrator account with a unique password.

NodeBB runtime configuration must remain inside the ignored upstream checkout.

## 6. Build and start NodeBB

```bash
./nodebb build
./nodebb start
./nodebb status
```

Once startup completes, open:

http://127.0.0.1:4567

## 7. Configure local email delivery

In the NodeBB administrator dashboard, open the email settings.

Configure:

- Sender: `TorqYard <noreply@torqyard.test>`
- SMTP transport: enabled
- Service: Custom
- Host: `127.0.0.1`
- Port: `1025`
- Connection security: None
- Username: blank
- Password: blank

Mailpit captures development messages without delivering them externally.

Open http://127.0.0.1:8025 to inspect verification messages.

## 8. Verify the installation

Confirm that:

1. NodeBB responds over HTTP.
2. The administrator can authenticate.
3. Email verification messages appear in Mailpit.
4. A discussion can be created.
5. The discussion survives a NodeBB restart.

These are manual checks. Automated integration tests remain outstanding.

## Existing legacy database

An installation created before the TorqYard naming correction may
use the Docker volume `torqueyard_postgres_data`.

To preserve that database, create the ignored file
`infra/development/compose.local.yaml`:

```yaml
volumes:
  postgres_data:
    external: true
    name: torqueyard_postgres_data
```

Use both Compose files for every Docker operation on that installation:

```bash
docker compose \
  -f infra/development/compose.yaml \
  -f infra/development/compose.local.yaml \
  up -d
```

Do not use the default Compose file alone for this legacy installation.

Do not run `docker compose down -v` against a database containing data
that must be preserved.

The existing PostgreSQL database and user may retain the name
`torqueyard`. This is an internal identifier, not the product brand.
