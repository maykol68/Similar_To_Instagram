class SearchController < ApplicationController

    def index
        @results = search_for_users

        respond_to do |format|
            format.turbo_stream do
                render turbo_stream:
                    turbo_stream.update("users",
                                        partial: "users/show",
                                        locals: { users: @results })
            end
        end
    end

    def suggestions
        @result = search_for_users
    end

    private

    def search_for_users
        if params[:query].blank?
            User.all
       else
            User.search(params[:query], Fields: %[uusername name], operator: "or", match: :text_middle)
       end
end
    end
end
