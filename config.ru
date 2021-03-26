require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#mounting controllers
use Rack::MethodOverride
use FriendsController
use LikesController
use UsersController
use ExercisesController
run ApplicationController
