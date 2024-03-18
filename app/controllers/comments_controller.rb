class CommentsController < ApplicationController
    before_action :authenticate_user!
    def create
        @comment = post.comments.build(comment_params)
        @comment.user = current_user
    
        if @comment.save
          NotificationServices.notify(post.user, current_user, "Ha comentado en tu post.")
          redirect_to post, notice: t('.created')
        else
          redirect_to post, status: :unprocessable_entity
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
