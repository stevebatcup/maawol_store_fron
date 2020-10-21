#!/bin/bash -e

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed

if [ $RAILS_ENV = 'production' ]
then
  bundle exec rails assets:precompile
fi


if [[ -a /usr/src/app/tmp/pids/server.pid ]]; then
	echo "Removing stale PID file from /usr/src/app/tmp/pids/server.pid...."
	rm /usr/src/app/tmp/pids/server.pid
fi

rails s -b 0.0.0.0 -p $PORT -P /usr/src/app/tmp/pids/server.pid