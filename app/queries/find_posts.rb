Class FindPosts
    def call
        scoped = filter_by_user_id(scoped, params[:user_id])
    end

    private

    def filter_by_user_id(scoped, user_id)  
        return scoped unless user.id.present?

        scoped.where(user_id: user_id)

    end
end