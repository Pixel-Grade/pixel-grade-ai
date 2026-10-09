WEB := pixel-grade-ai
API := pixel-grade-ai-server

.PHONY: install dev dev-web dev-api deploy

install:
	cd $(WEB) && npm ci
	cd $(API) && npm ci

# runs web + api together: make dev
dev:
	$(MAKE) -j2 dev-web dev-api

dev-web:
	cd $(WEB) && npm run dev

dev-api:
	cd $(API) && npm run dev:local

# push main (as the pixelgrade git identity), then deploy API to Elastic Beanstalk.
# web: assumed to deploy from the push (e.g. Vercel git integration).
deploy:
	git pokemon
	git push origin main
	cd $(API) && npm run deploy
