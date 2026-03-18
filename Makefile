RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --service mattermost-app
	railway service status --all --json | jq -r '.[] | select(.name == "mattermost-app") | .id' | xargs -I{} railway volume -s {} add --mount-path /mattermost/data
	railway up app --path-as-root --service mattermost-app
	railway variable set --service mattermost-app \
	  PORT=8065 \
	  MM_SQLSETTINGS_DRIVERNAME=postgres \
	  'MM_SQLSETTINGS_DATASOURCE=$${{Postgres.DATABASE_URL}}' \
	  MM_SERVICESETTINGS_LISTENADDRESS=:8065 \
	  MM_SERVICESETTINGS_SITEURL=https://mattermost.railway.com

destroy:
	@echo "Delete services via Railway dashboard: mattermost-app, Postgres"
	@echo "https://railway.com/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service mattermost-app --lines 100

.PHONY: deploy destroy status logs
