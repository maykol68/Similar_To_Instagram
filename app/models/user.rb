class User < ApplicationRecord

  include PgSearch::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

    pg_search_scope :search_full_text, against: {
      username: 'A'
      name: 'B' 
    }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name #assuming the user model has a name
      user.avatar_url = auth.info.image #assuming the user model has an image
      # if you are using confirmable and the provider(s) you use validate emails,
      # uncomment th line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followers, foreign_key: :follower_id, class_name: 'Follower'
  has_many :followed_users, through: :followers, source: :followed

  has_many :followed, foreign_key: :followed_id, class_name: 'Follower'
  has_many :followers_users, through: :followed, source: :follower
  
  before_save :downcase_attributes

  def downcase_attributes
      self.username = username.downcase
      self.email = email.downcase
  end
  
end
