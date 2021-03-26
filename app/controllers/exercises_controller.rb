class ExercisesController < ApplicationController
    get '/exercises/new' do
        erb :'/exercises/new'
    end

    post '/exercises' do
        if !logged_in?
            flash[:message] = "Unauthorized. Please Log In or Sign Up."
            redirect '/'
        else
            if params[:name] != "" && params[:muscle_group] != "" && params[:sets] != "" && params[:reps] != "" && params[:description] != ""
                @exercise = Exercise.create(params)
                @exercise.user_id = session[:user_id]
                @exercise.save
                flash[:message] = "Exercise Successfully Created."
                redirect "/exercises/#{@exercise.id}"
            else
                flash[:message] = "Please fill out all the required fields."
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
                flash[:message] = "Unauthorized"
                redirect "/users/#{current_user.slug}"
            end
        else
            flash[:message] = "Unauthorized. Please Log in or Sign up."
            redirect '/'
        end
    end

    patch '/exercises/:id' do
        set_exercise
        if logged_in?
            if authorized?(@exercise) && params[:name] != "" && params[:muscle_group] != "" && params[:sets] != "" && params[:reps] != "" && params[:description] != ""
                @exercise.update(name: params[:name], muscle_group: params[:muscle_group], sets: params[:sets], reps: params[:reps], description: params[:description])
                flash[:message] = "Exercise Successfully Updated."
                redirect "/exercises/#{@exercise.id}"
            else
                flash[:message] = "Unauthorized"
                redirect "/users/#{current_user.slug}"
            end
        else
            flash[:message] = "Unauthorized. Please Log In or Sign Up."
            redirect '/'
        end
    end

    delete '/exercises/:id' do
        set_exercise
        if authorized?(@exercise)
            @exercise.destroy
            flash[:message] = "Exercise Successfully deleted."
            redirect "/users/#{current_user.slug}"
        else
            flash[:message] = "Unauthorized"
            redirect "/users/#{current_user.slug}"
        end
    end

    get '/oldest' do
        erb :'/exercises/oldest'
    end

    get '/newest' do
        erb :'/exercises/newest'
    end

    get '/top' do
        erb :'/exercises/top'
    end

    get '/search' do
        if !logged_in?
            flash[:message] = "Unauthorized. Please Log In or Sign Up."
            redirect '/'
        else
            if Exercise.find_by(muscle_group: params["search"])
                @muscle_group = params["search"]
                erb :'/exercises/all_muscles'
            elsif Exercise.find_by(name: params["search"])
                @name = params["search"]
                erb :'/exercises/all_names'
            elsif User.find_by(username: params["search"])
                @user = params["search"]
                erb :'/users/all_users'
            else
                flash[:message] = "No Results."
                redirect back
            end
        end
    end

    private

    def set_exercise
        #params refreshed everytime its called on, scoped to controller
        @exercise = Exercise.find(params[:id])
    end
end