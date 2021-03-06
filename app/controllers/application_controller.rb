require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get "/" do
    if !logged_in?
      erb :welcome
    else
      redirect "/users/#{current_user.slug}"
    end
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

    def authorized?(exercise)
      exercise.user == current_user
    end

    def already_added?
      Friend.where(user_id: current_user.id, friend_id:
      @user.id).exists?
    end

  end

end
