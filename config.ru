require './config/environment'


#mounting controllers
use Rack::MethodOverride
use FriendsController
use LikesController
use UsersController
use ExercisesController
run ApplicationController
