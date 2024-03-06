class CommentsController < ApplicationController
    def create
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
    
        if @comment.save
          redirect_to @post, notice: ('.created')
        else
          redirect_to @post, status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def post 
        @post = Post.find(params[:post_id])
    end
end
