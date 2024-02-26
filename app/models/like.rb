class Like < ApplicationRecord

  validates :user, uniqueness: { scope: :post}

  has_many :user
  has_many :post

end
