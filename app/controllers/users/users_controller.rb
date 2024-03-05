class UsersController < ApplicationController

    def show
        @user = User.find_by!(username: params[:username])
        @pagy, @posts = pagy_countless(FindPosts.new.call({user_id: @user.id}).load_async, items: 12)   
    end
end