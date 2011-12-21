#- Requires that we need for our app
require 'bundler/setup'
require 'erb'
require 'json'
require 'tilt'
require 'logger'
require 'goliath'
require 'goliath/rack/templates'

#- Setup simple audit logging
AUDIT_LOG = Logger.new('log/audit.log')

#- Loadup app controller
# This has to be done because order of directory iterator below
require './config/application_controller'

#- Loadup everything (has to be done after goliath is loaded)
Dir['./config/*.rb'].each {|file| require './config/' + File.basename(file, File.extname(file)) }
Dir['./lib/*.rb'].each {|file| require './lib/' + File.basename(file, File.extname(file)) }
Dir['./app/models/*.rb'].each {|file| require './app/models/' + File.basename(file, File.extname(file)) }
Dir['./app/controllers/*.rb'].each {|file| require './app/controllers/' + File.basename(file, File.extname(file)) }

