# Mattermost

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-mattermost)

Open-source team messaging (Slack alternative).

**Services:** `mattermost-app`, `Postgres` (Railway-managed)
**Persistent volume:** `/mattermost/data`

## Deploy

```bash
make deploy
```

## Post-Deploy

Update `SITEURL` to your Railway domain:
```bash
railway variable set --service mattermost-app \
  MM_SERVICESETTINGS_SITEURL=https://your-domain.railway.app
```
