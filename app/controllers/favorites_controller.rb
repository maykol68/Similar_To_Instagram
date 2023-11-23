class FavoritesController < ApplicationController

    def create
        Favorite.create(post: post, user: current_user)
        redirect_to post_path(product)
    end

    private

    def post
       @post ||= Product.find(params[:post_id])
    end

end