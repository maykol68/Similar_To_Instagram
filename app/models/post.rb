class Post < ApplicationRecord
    has_one_attached :photo



    validates :title, length: { maximum: 25 }
    validates :description, length:  { maximum: 300 }
    validates :photo, presence: true

    belongs_to :user, default -> { current_user }
end
