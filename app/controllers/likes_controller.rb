class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:index, :create, :destroy]

  def index

  end
  
  def create
    @post.like!
    redirect_to post_path(@post)
  end

  def destroy
    @post.dislike!
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post ||= Post.find(params[:post_id])
  end
end