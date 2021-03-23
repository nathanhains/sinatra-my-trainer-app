class ExercisesController < ApplicationController
    get '/exercises/new' do
        erb :'/exercises/new'
    end

    post '/exercises' do
        if !logged_in?
            redirect '/'
        else
            if params[:name] != "" && params[:muscle_group] != "" && params[:sets] != "" && params[:reps] != "" && params[:description] != ""
                @exercise = Exercise.create(params)
                @exercise.user_id = session[:user_id]
                redirect "/exercises/#{@exercise.id}"
            else
                #include failure message
                redirect '/exercises/new'
            end
        end
    end

    get '/exercises/:id' do
        @exercise = Exercise.find_by(id: params[:id])
        @user = User.find_by(id: "#{@exercise.user_id}")
        erb :'/exercises/show'
    end

    get '/feed' do
        erb :'/exercises/all'
    end

    get '/search' do
        erb :'/exercises/search'
    end

    post '/search' do
        if !logged_in?
            redirect '/'
        else
            if Exercise.find_by(muscle_group: params["search"].capitalize())
                @muscle_group = params["search"].capitalize
                erb :'/exercises/all_muscles'
            elsif Exercise.find_by(name: params["search"].titleize)
                @name = params["search"].titleize
                erb :'/exercises/all_names'
            elsif User.find_by(username: params["search"])
                @user = params["search"]
                erb :'/users/all_users'
            else
                redirect '/search'
            end
        end
    end

end