class ExercisesController < ApplicationController
    get '/exercises/new' do
        erb :'/exercises/new'
    end

    post '/exercises' do
        if params[:name] != "" && params[:muscle_group] != "" && params[:sets] != "" && params[:reps] != "" && params[:description] != ""
            @exercise = Exercise.create(params)
            @exercise.user_id = session[:user_id]
            redirect "/exercises/#{@exercise.id}"
        else
            #include failure message
            redirect '/exercises/new'
        end
    end

    get '/exercises/:id' do
        @exercise = Exercise.find_by(id: params[:id])
        erb :'/exercises/show'
    end
end