# What is it?

This project is a API for tree manipulation from https://random-tree.herokuapp.com/. This project is made on Rails 5 + Sidekiq

# What is the project for?

The project was made to help computer programmers who are applying for positions in companies, during the interview process. However, I strongly recommend that you DO NOT COPY THIS WHOLE PROJECT, but try to use it as reference for your solution. I suggest it to you because it is important to show your recruiter how you solve problems in a smart way without doing "copy and paste".


# How to use it?

### With docker
After you've cloned this project, follow the steps:
- open a terminal session in your terminal tool (Iterm, Terminal, etc)
- go to the folder where you've cloned the project (Ex.: ```cd growth-tribe-dynamic-tree-api```)
- type the command: ```make run```

This command will run the container, run the commands `bundle install` and open a session inside the container. If daddy from heaven was kind and the guy who did it had some competence, the container has been started ```/usr/src/app #```

At the first time, you have to type the command `rails db:setup`

At this point, you can run the rails server (`rails s -b 0.0.0.0`) or run rails console (`rails c`) or anything else (`rake db:migrate, rspec`)

### Without docker

Assuming you have a ruby environment in your machine:
- set the environment variables REDIS_URL and REDIS_PROVIDER. These variable are required by sidekiq. Ex.:
    ````
    export REDIS_URL=redis://MY-REDIS-HOST:6379/0
    export REDIS_PROVIDER=REDIS_URL
    ````
- enable a Postgree database (AWS RDS or install in your localmachine) and add postgres user into `config/database.yml`
- open a terminal session
- go to the folder where you've cloned the project (Ex.: ```cd growth-tribe-dynamic-tree-api```)
- type the commands (only for the first time you have to work in the project):
    -  `bundle install`
    - `rails db:setup`
    - `bundle exec sidekiq`
-  open a second terminal session
-  go to the folder where you've cloned the project (Ex.: ```cd growth-tribe-dynamic-tree-api```)
-  run rails server (`rails s`) or run rails console (`rails c`) or anything else


## API endpoints
You can test the API using this Insonomia (https://insomnia.rest/) workspace (https://drive.google.com/file/d/1MuiymnRxP-GM9853kbhpzwQTpbFBRXW5/view?usp=sharing). Download it and import into your Insomnia. The Insomnia workspace contains two environments: local and production.

__IMPORTANT:__ in the insonomia requests `GET /trees/:id/nodes/:id`, `GET /trees/:id/nodes/:id/children_ids`, `GET /trees/:id/nodes/:id/parents_ids`, the URL is static because Insonomia doesn't have env var for specific requests (https://support.insomnia.rest/article/43-chaining-requests). When you are testing, edit the URL and replace the static values

- `GET /`: list available trees
- `GET /trees`: list available trees
- `GET /trees/:id`: show the tree detail
- `GET /trees/:id/nodes`: show the tree's nodes list
- `GET /trees/:id/nodes/:id`: show the node detail
- `GET /trees/:id/nodes/:id/children_ids`: list all descendants nodes IDs
- `GET /trees/:id/nodes/:id/parents_ids`: list all ancestors nodes IDs

# Automated testing
To run the tests, to go the terminal session where you've run `make run` and type `rspec` (Ex.: `/usr/src/app # rspec`)

# Deploy to production
- Heroku: There is an app.json and a Procfile to help to deploy the project into heroku. Futhermore, after the `git push heroku master`, you have to log in in your heroku app , go to the "Overview" page of your project and to enable sidekiq worker (Configure Dynos)
- Docker Swarm: You can create the Dockerfile copying from Dockerfile-local and push it to your dockerhub. I promise to you when were possible, I will create in this project a Dockerfile to production
- Kubernet: I promise to you when were possible, I will create in this project a Podfile to production

## General Remarks
- Docker Environemnt
-- to destroy the environemnt, to go the terminal session where you've run `make run` and type `exit`. After that, type `make destroy`
-- In the Makefile there are extra commands to run rails server, rails console and rspec.
