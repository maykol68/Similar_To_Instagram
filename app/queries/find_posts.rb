class FindPosts
    attr_reader :posts

    def initialize(posts = initial_scope)
        @posts = posts
    end

    def call(params = {})
        scoped =posts
        scoped = filter_by_user_id(scoped, params[:user_id])
        scoped = filter_by_likes(scoped, params[:likes] )
        scoped = filter_by_query_text(scoped, params[:query_text])
    end
    
    private

    def initial_scope
        Post.with_attached_photo
    end

    def filter_by_user_id(scoped, user_id)
        return scoped unless user_id.present?

        scoped.where(user_id: user_id)
    end

    def filter_by_likes(scoped, likes )
        return scoped  unless likes.present?

        scoped.joins(:likes).where(likes: { user_id: current_user.id })
    end

    def filter_by_query_text(scoped, query_text)
        return scoped unless query_text.present?
    
        scoped.search_full_text(query_text)
      end
end