class FollowsController < ApplicationController
  before_action :authenticate_user!

  def follow
    user_to_follow = User.find_by(username: params[:username])
    current_user.followed_users << user_to_follow
    NotificationServices.notify_follow(current_user, user_to_follow, "Te ha comenzado a seguir.")
    redirect_to user_profile_path(user_to_follow.username), notice: t(".followed", username: user_to_follow.username)
  end

  def unfollow
    user_to_unfollow = User.find_by(username: params[:username])
    current_user.followed_users.delete(user_to_unfollow)
    redirect_to user_profile_path(user_to_unfollow.username), notice: t(".unfollowed", username: user_to_unfollow.username)
  end
end