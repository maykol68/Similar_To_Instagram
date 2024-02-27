class Post < ApplicationRecord
    include Likeable
  
    has_one_attached :photo
  
    validates :title, length: { maximum: 25 }
    validates :description, length: { maximum: 300 }
    validates :photo, presence: true
  
    belongs_to :user
    acts_as_tenant :user  # Esto establece la asociación con el usuario como el inquilino

    before_validation :set_default_user
  
    def owner?
      self.user == Current.user
    end
  
    private
  
    def set_default_user
      self.user ||= Current.user
    end
  end