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
                @exercise.save
                redirect "/exercises/#{@exercise.id}"
            else
                #include failure message
                redirect '/exercises/new'
            end
        end
    end

    get '/exercises/:id' do
        set_exercise
        @user = User.find_by(id: "#{@exercise.user_id}")
        erb :'/exercises/show'
    end

    get '/exercises/:id/edit' do
        set_exercise
        if logged_in?
            if authorized?(@exercise)
                erb :'/exercises/edit'
            else
                redirect "/users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    patch '/exercises/:id' do
        set_exercise
        if logged_in?
            if authorized?(@exercise)
                @exercise.update(name: params[:name], muscle_group: params[:muscle_group], sets: params[:sets], reps: params[:reps], description: params[:description])
                redirect "/exercises/#{@exercise.id}"
            else
                redirect "/users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    delete '/exercises/:id' do
        set_exercise
        if authorized?(@exercise)
            @exercise.destroy
            redirect "/users/#{current_user.id}"
        else
            
        end
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

    private

    def set_exercise
        #params refreshed everytime its called on, scoped to controller
        @exercise = Exercise.find(params[:id])
    end
end