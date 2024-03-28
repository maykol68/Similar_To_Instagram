class UsersController < ApplicationController
    before_action :authenticate_user!

    def index

        if params[:query_text].present?
          @users = User.where("username Like ?", "%"+params[:query_text]+"%" )
        else 
          @users = User.all
        end
    end

    def show
        @user = User.find_by!(username: params[:username])
        @users = User.all_except(current_user)
        

        @room = Room.new
        @rooms = Room.public_rooms
        @room_name = get_name(@user, current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(created_at: :asc)
        render 'rooms/index'
    end

    def show_profile
      @user = User.find_by(username: params[:username])
      @followers = @user.followers
      @followed_users = @user.followed_users


      @pagy, @posts = pagy_countless(FindPosts.new.call({user_id: @user&.id}).load_async, items: 12)
    end

      private

      def get_name(user1, user2)
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
      end
end