@echo off

set RUBYOPT=-EUTF-8

cd /D %~dp0
cd ../
bundle exec ruby app.rb -p 80