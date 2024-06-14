#!/usr/bin/env puma

directory "/home/sites/manganotifier/current"
rackup "/home/sites/manganotifier/current/config.ru"
environment "production"

tag ""

pidfile "/home/sites/manganotifier/shared/tmp/pids/puma.pid"
state_path "/home/sites/manganotifier/shared/tmp/pids/puma.state"
stdout_redirect "/home/sites/manganotifier/shared/log/puma_access.log", "/home/sites/manganotifier/shared/log/puma_error.log", true

threads 0, 5

bind "unix:///home/sites/manganotifier/shared/tmp/sockets/puma.sock"

workers 6

restart_command "bundle exec puma"

prune_bundler

on_restart do
  puts "Refreshing Gemfile"
  ENV["BUNDLE_GEMFILE"] = ""
end
