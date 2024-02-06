class Post < ApplicationRecord
    include Favoritable


    has_one_attached :photo

    validates :title, length: { maximum: 25 }
    validates :description, length:  { maximum: 300 }
    validates :photo, presence: true

    belongs_to :user, default: ->{current_user } 
    before_create :owner?

    def owner?
        self.user = current_user
    end

    

end
