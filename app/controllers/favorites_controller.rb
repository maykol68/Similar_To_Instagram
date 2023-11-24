class FavoritesController < ApplicationController

    def create
        product.favorite!
        redirect_to post_path(post)
    end

    def destroy
        post.unfavorite!
        redirect_to post_path(post), status: :see_other
    end
    
    private

    def post
       @post ||= Post.find(params[:post_id])
    end

end