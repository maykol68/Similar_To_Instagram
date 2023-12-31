class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    
  end

  def new
    @post = Post.new
  end


  def edit
    authorize! set_post
  end

  def create
    @post = Post.new(post_params)

    
      if @post.save
        redirect_to post_url(@post), notice: t('created') #"Post was successfully created." 
        
      else
        render :new, status: :unprocessable_entity 
        
      end
  end

  def update
      authorize! set_post
      if @post.update(post_params)
          redirect_to post_url(@post), notice: t('updated')
          
      else
        render :edit, status: :unprocessable_entity 
      end
    
  end

  def destroy
    authorize! set_post
    @post.destroy
      redirect_to posts_url, notice: t('destroyed'), status: :see_other #"Post was successfully destroyed." 

  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    

    def post_params
      params.require(:post).permit(:title, :description, :photo)
    end
end
