RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --service mattermost-app
	railway volume -s mattermost-app add --mount-path /mattermost/data
	cd app && railway up --service mattermost-app
	railway variable set --service mattermost-app \
	  MM_SQLSETTINGS_DRIVERNAME=postgres \
	  'MM_SQLSETTINGS_DATASOURCE=${{Postgres.DATABASE_URL}}' \
	  MM_SERVICESETTINGS_SITEURL=https://mattermost.railway.app

destroy:
	@echo "Delete services via Railway dashboard: mattermost-app, Postgres"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service mattermost-app --lines 100

.PHONY: deploy destroy status logs
