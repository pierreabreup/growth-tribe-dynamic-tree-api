SHELL := /bin/bash # Use bash syntax

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir_name := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

run:
	docker-compose run --service-ports --name rails5-container --rm app

down:
	docker-compose down

rserver:
	docker exec -it rails5-container bash -c "rails s -b 0.0.0.0"

rconsole:
	docker exec -it rails5-container bash -c "rails c"

rtest:
	docker exec -it rails5-container bash -c "rspec"

destroy:
	docker-compose down
	docker volume rm ${current_dir_name}_rails5-usrlocal
	docker volume rm ${current_dir_name}_postgres-data
	docker rmi dynamic-tree-api:local
	docker rmi postgres:latest
	docker rmi redis:4-alpine

