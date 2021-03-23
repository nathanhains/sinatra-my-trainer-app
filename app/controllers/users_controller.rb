class UsersController < ApplicationController

    #route usage: to render login form
    get '/login' do
        erb :'/users/login'
    end

    #route usage: to receive login form & create a session(find user, log user in)
    post '/login' do
        @user = User.find_by(username: params[:username])
        #is the user in the database?
        if @user && @user.authenticate(params[:password])
            #create session
            session[:user_id] = @user.id
            redirect "/users/#{@user.slug}"
        else
            redirect "/login"
        end

    end

    #render signup form
    get '/signup' do
        erb :'users/signup'
    end

    post '/users' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.slug}"
        else
            #include failure message
            redirect '/signup'
        end
    end
    
    #show user route
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end