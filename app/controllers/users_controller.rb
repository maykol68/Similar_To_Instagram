class UsersController < ApplicationController
    before_action :set_user_follow, only: [:follow, :unfollow]

    def index
        @users = User.all

        if params[:query_text].present?
          @users = @users.search_full_text(params[:query_text])
        end
    end

    def show
        @user = User.find(username: params[:username])
        @users = User.all_except(current_user)

        @room = Room.new
        @rooms = Room.public_rooms
        @room_name = get_name(@user, current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(created_at: :asc)
        render 'rooms/index'

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

      private

      def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
      end
end