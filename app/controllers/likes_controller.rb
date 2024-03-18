class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :post, only: [:create, :destroy]

  def index
    @likes = current_user.likes.includes(:post)
  end
  
  def create

    post.like!(current_user)
    NotificationServices.notify(post.user, current_user, "Le ha gustado tu post.")
    redirect_to post_path(post)
  end

  def destroy
    post.dislike!(current_user)
    redirect_to post_path(post)
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end
end