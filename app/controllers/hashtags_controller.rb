class HashtagsController < ApplicationController
    def show
      @hashtag = Hashtag.find(params[:id])
      @posts = @hashtag.posts
    end
end