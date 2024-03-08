class Post < ApplicationRecord
    include Likeable

    has_one_attached :photo
  
    validates :title, length: { maximum: 25 }
    validates :description, length: { maximum: 500 }
    validates :photo, presence: true

    has_and_belongs_to_many :hashtags

    has_many :comments, dependent: :destroy
    
    belongs_to :user, dependent: :destroy
    acts_as_tenant :user  # Esto establece la asociación con el usuario como el inquilino

    def owner?(current_user)
      user_id == current_user&.id
    end
end