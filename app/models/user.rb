class User < ApplicationRecord

  include PgSearch::Model
  
  pg_search_scope :search_full_text, against: [
    [:username, 'A'],
  ]
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages
  has_many :notifications, as: :recipient
  


  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Follower'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followed_relationships, foreign_key: :follower_id, class_name: 'Follower'
  has_many :followed_users, through: :followed_relationships, source: :followed
  
  before_save :downcase_attributes
  
  devise :omniauthable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name #assuming the user model has a name
      user.username = auth.info.email.split('@').first
      user.avatar_url = auth.info.image #assuming the user model has an image
      # if you are using confirmable and the provider(s) you use validate emails,
      # uncomment th line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  

  def downcase_attributes
    self.username = username.downcase if username.present?
    self.email = email.downcase if email.present?
  end
  
end
