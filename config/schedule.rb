# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


# ===
# APIの自動取得
# ===
set :job_template, "/bin/zsh -l -c ':job'"
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"
#railsアプリフォルダ内の./log/cron.logにログが出力されるようにする記述

set :path_env, ENV['PATH']
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
#railsアプリ内の実行環境を変数に代入している

# job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"
#railsアプリ上の実行環境と同条件になるよう規定している
#:outputで事前にsetしたパスにログの出力先を設定


every 1.minutes do
    rake "fetch_api:twitch"
end 

# 定期実行
# bundle exec whenever --update-crontab

# 定期実行の解除
# bundle exec whenever --clear-crontab

# ===
# 古いsession情報の自動削除
# ===

every 1.day, at: '3:00' do
    rake 'db:sessions:trim'
end