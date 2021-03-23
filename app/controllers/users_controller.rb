class UsersController < ApplicationController
    #route usage: to render login form
    get '/login' do
        erb :'/users/login'
    end

    #route usage: to receive login form & create a session(find user, log user in)
    post '/login' do

    end

    get '/signup' do
    end
end