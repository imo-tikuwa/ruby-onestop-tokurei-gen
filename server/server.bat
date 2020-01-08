@echo off

set RUBYOPT=-EUTF-8

cd /D %~dp0
cd ../
bundle exec ruby app.rb -o 0.0.0.0 -p 80