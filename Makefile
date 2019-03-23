SHELL := /bin/bash # Use bash syntax

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir_name := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

run:
	docker-compose run --service-ports --name rails5-container --rm app

down:
	docker-compose down

rs:
	docker exec -it rails5-container bash -c "cd */ && rails s"

rc:
	docker exec -it rails5-container bash -c "cd */ && rails c"

destroy:
	docker-compose down
	docker volume rm ${current_dir_name}_rails5-usrlocal
	docker rmi rails5
