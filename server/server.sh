#!/bin/bash

APP_ROOT=$(dirname $(cd $(dirname $0); pwd))
cd $APP_ROOT

bundle exec ruby app.rb -o 0.0.0.0 -p 3000 >> $APP_ROOT/log/application.log 2>&1 &