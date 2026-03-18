# Deploy and Host Mattermost on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/mattermost-1)

Mattermost is an open-source, self-hosted team messaging and collaboration platform. It provides chat channels, direct messages, file sharing, and integrations as a privacy-first alternative to Slack and Microsoft Teams.

## About Hosting Mattermost

Hosting Mattermost requires a persistent application server and a relational database. The app server handles HTTP connections, WebSocket push notifications, file uploads, and plugin execution. A PostgreSQL database stores all messages, users, and configuration. Data written to the server (attachments, custom emoji, plugins) must be stored on a persistent volume so it survives redeployments. Mattermost exposes a health endpoint at `/api/v4/system/ping` that Railway uses to confirm the service is ready before routing traffic.

## Common Use Cases

- Internal team communication and channels for engineering or ops teams
- Self-hosted Slack replacement for organizations with strict data-residency requirements
- Incident-response coordination hub with bots and webhook integrations
- Development collaboration platform with GitLab/GitHub/Jira integrations
- Secure messaging for regulated industries (healthcare, finance, government)

## Dependencies for Mattermost Hosting

- PostgreSQL database (Railway-managed Postgres service)
- Persistent volume mounted at `/mattermost/data`

### Deployment Dependencies

- Docker image: [mattermost/mattermost-team-edition on Docker Hub](https://hub.docker.com/r/mattermost/mattermost-team-edition)
- Mattermost configuration reference: [https://docs.mattermost.com/configure/configuration-settings.html](https://docs.mattermost.com/configure/configuration-settings.html)
- Mattermost self-hosted install guide: [https://docs.mattermost.com/guides/deployment.html](https://docs.mattermost.com/guides/deployment.html)

### Implementation Details

The template deploys the official `mattermost/mattermost-team-edition` Docker image. All configuration is passed via environment variables prefixed with `MM_` (Mattermost's standard env-var config mechanism). The Railway-managed Postgres service connection string is injected automatically via `${{Postgres.DATABASE_URL}}`. After the first deploy, update `MM_SERVICESETTINGS_SITEURL` to your assigned Railway domain so that invite links, email notifications, and OAuth redirects work correctly.

## Why Deploy Mattermost on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Mattermost on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
