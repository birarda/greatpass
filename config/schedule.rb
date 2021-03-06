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

every 1.hour do
  command 'AWS_SHARED_CREDENTIALS_FILE="/home/birarda/pg-backups/.aws-config" /var/www/greatpass/current/lib/cron/db_backup.sh hourly'
end

every 1.day do
  command 'AWS_SHARED_CREDENTIALS_FILE="/home/birarda/pg-backups/.aws-config" /var/www/greatpass/current/lib/cron/db_backup.sh daily'
end

every :monday, at: '5am' do
  command 'AWS_SHARED_CREDENTIALS_FILE="/home/birarda/pg-backups/.aws-config" /var/www/greatpass/current/lib/cron/db_backup.sh weekly'
end

every 1.day, at: '5am' do
  rake "-s sitemap:refresh"
end
