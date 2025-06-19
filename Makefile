.PHONY: db-up
db-up:
	docker compose up -d

.PHONY: db-down
db-down:
	docker compose down

.PHONY: db-down-clean
db-down-clean:
	docker compose down --volumes --remove-orphans

.PHONY: lint
lint:
	bundle exec rubocop -a

.PHONY: run
run:
	bin/dev

.PHONY: create
create:
	bin/rails db:create

.PHONY: migrate
migrate:
	bin/rails db:migrate

.PHONY: test
test:
	bundle exec rspec