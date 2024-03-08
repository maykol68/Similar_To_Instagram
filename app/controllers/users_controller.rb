class UsersController < ApplicationController
    before_action :set_user_follow, only: [:follow, :unfollow]

    def show
        @user = User.find_by!(username: params[:username])
        @pagy, @posts = pagy_countless(FindPosts.new.call({user_id: @user.id}).load_async, items: 12)   
    end

    def follow
        current_user.followed_users << @user_follow
        redirect_to @user_follow, notice: 'Ahora sigues a este usuario.'
      end
    
      def unfollow
        current_user.followed_users.delete(@user_follow)
        redirect_to @user_follow, notice: 'Ya no sigues a este usuario.'
      end

      def set_user_follow
        @user_follow = User.find(params[:id])
      end
end