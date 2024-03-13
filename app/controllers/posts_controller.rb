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
     @post
  end

  def create
    ActsAsTenant.with_tenant(current_user) do
    @post = Post.new(post_params)

      if @post.save

        hashtags = params[:post][:hashtags].split(",").map(&:strip)
        hashtags.each do |tag_name|
          hashtag = Hashtag.find_or_create_by(name: tag_name)
          @post.hashtags << hashtag
        end
        redirect_to @post, notice: t('.created')
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
     @post
    if @post.update(post_params)
      redirect_to @post, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
     @post
    @post.destroy!
    redirect_to posts_url, notice: t('.destroyed'), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params_index
    params.permit(:page, :likes, :user_id, :query_text)
  end

  def post_params
      params.require(:post).permit(:title, :description, :photo, hashtag_ids: [])
  end
end