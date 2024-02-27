module Likeable 
    extend ActiveSupport::Concern
  
    included do
      has_many :likes, dependent: :destroy
         
      def like!(current_user)
         likes.create(user: current_user)
      end

      def dislike!(current_user)
        like(current_user)&.destroy
      end
  
      def like(current_user)
        likes.find_by(user: current_user)
      end
    end
  end