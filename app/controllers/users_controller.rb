class UsersController < ApplicationController
    #route usage: to render login form
    get '/login' do
        erb :'/users/login'
    end

    #route usage: to receive login form & create a session(find user, log user in)
    post '/login' do
        @user = User.find_by(username: params[:username])
        #is the user in the database?
        if @user.authenticate(params[:password])
            #create session
            session[:user_id] = @user.id
            redirect "users/#{@user.id}"
        else

        end

    end

    get '/signup' do
    end

    get '/users/:id' do
        "Helllooooo"
    end
end