#!/bin/bash

set -e

bundle install
rails db:setup
rails db:migrate
rails db:seed

exec "$@"
