class User < ApplicationRecord

  include PgSearch::Model
  
  has_one_attached :avatar

  pg_search_scope :search_full_text, against: [
    [:username, 'A'],
  ]
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages
  has_many :notifications, as: :recipient, dependent: :destroy
  
  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower, class_name: 'User'
  
  has_many :followed_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followed_users, through: :followed_relationships, source: :followed, class_name: 'User'
  
  devise :omniauthable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

  scope :all_except, ->(user) { where.not(id: user) }

  validates :username, presence: true, uniqueness: true


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name #assuming the user model has a name
      user.username = auth.info.email.split('@').first
      user.avatar_url = auth.info.image #assuming the user model has an image

      if auth.extra.raw_info.birthday.present?
        user.birth_date = Date.strptime(auth.extra.raw_info.birthday, '%Y-%m-%d')
      end
      # if you are using confirmable and the provider(s) you use validate emails,
      # uncomment th line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end


  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  
  
end
