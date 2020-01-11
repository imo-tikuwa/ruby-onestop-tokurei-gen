@echo off

cd /D %~dp0
cd ../
bundle exec ruby app.rb -o 0.0.0.0 -p 80 >> log/application.log 2>&1