module Favoritable
    extend ActiveSupport::Concern

    included do 
        has_many :favorites, dependent: :destroy
        
        def favorite!
            favorites.create(user: current_user)
        end
    
        def unfavorite!
            favorite.destroy
        end
        
        def favorite
            favorites.find_by(user: current_user)
        end
    end
end