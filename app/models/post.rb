class Post < ApplicationRecord
    include Likeable
    include PgSearch::Model

    pg_search_scope :search_full_text, against: [
      [:title, 'A'],
      [:description, 'B']
    ]
    
    has_one_attached :photo
    has_and_belongs_to_many :hashtags, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    belongs_to :user
    acts_as_tenant :user  # Esto establece la asociación con el usuario como el inquilino
  
    validates :title, length: { maximum: 25 }
    validates :description, length: { maximum: 500 }
    validates :photo, presence: true



    def owner?(current_user)
      user_id == current_user&.id
    end
end