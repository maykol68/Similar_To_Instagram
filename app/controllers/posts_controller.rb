class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @pagy, @posts = pagy_countless(FindPosts.new.call(post_params_index).load_async, items: 12)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    authorize! @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! @post
    if @post.update(post_params)
      redirect_to @post, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @post
    @post.destroy!
    redirect_to posts_url, notice: t('.destroyed'), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params_index
    params.permit(:page, :likes, :user_id)
  end
end