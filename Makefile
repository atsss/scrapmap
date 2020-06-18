.DEFAULT_GOAL := default

SYNC = docker-sync
CONMPOSE = docker-compose
WEB = $(CONMPOSE) exec web
RAILS = $(WEB) bundle exec rails

up:
	@$(SYNC) start
	@$(CONMPOSE) up -d
down:
	@$(CONMPOSE) down
	@$(SYNC) clean
restart:
	@$(SYNC) restart
	@$(CONMPOSE) restart
clean:
	@$(CONMPOSE) rm -v -a
bundle:
	@$(WEB) bundle
yarn:
	@$(WEB) yarn
webpack:
	@$(WEB) ./bin/webpack-dev-server
mysql:
	@$(CONMPOSE) exec mysql bash
rub:
	@$(WEB) bundle exec rubocop
autorub:
	@$(WEB) bundle exec rubocop -a
rs:
	@$(RAILS) s -b 0.0.0.0 -p 50272
default:
	@$(WEB) bash
