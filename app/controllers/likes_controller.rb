class UsersController < ApplicationController
    get '/likes/:id' do
        find_exercise
        if already_liked?
            flash[:message] = "You cannot like more than once."
            redirect back
        else
            @exercise.likes.create(user_id: current_user.id, exercise_id: @exercise.id)
            redirect back
        end
    end 

    private

    def find_exercise
        @exercise = Exercise.find(params[:id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, exercise_id:
        params[:id]).exists?
    end
end