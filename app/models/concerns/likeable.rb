module Likeable 
    extend ActiveSupport::Concern
  
    included do
      has_many :likes, dependent: :destroy
  
      def like!
        likes.create(user: Current.user)
      end
  
      def dislike!            
        like&.destroy
      end
  
      def like
        likes.find_by(user: Current.user)
      end
    end
  end