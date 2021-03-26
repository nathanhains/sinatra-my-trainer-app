class FriendsController < ApplicationController
    get '/friends/:id' do
        @user = User.find(params[:id])
        if already_added?
            flash[:message] = "User already added."
            redirect back
        else
            current_user.friends << Friend.create(user_id: current_user.id, friend_id: @user.id)
            redirect back
        end
    end
end