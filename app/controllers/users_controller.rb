class UsersController < ApplicationController
    get '/login' do
        erb :'/users/login'
    end

    get '/signup' do
    end
end