# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'

require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/puma'
require 'capistrano/puma/nginx'

require "capistrano/datadog"
set :datadog_api_key, "b1a9a696176b2c58f3fafb7b782349b7"

require 'capistrano/file-permissions'
before "deploy:updated", "deploy:set_permissions:chmod"

require 'whenever/capistrano'

require 'capistrano/sitemap_generator'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
