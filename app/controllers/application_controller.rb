require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "youwillneverguess"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    
    def logged_in?
      # double bang operator to return true
      !!current_user
    end

    def current_user
      #reduces database calls(memoization) if its already populated, wont get database again
      @current_user ||= User.find_by(id: session[:user_id])
    end

end
