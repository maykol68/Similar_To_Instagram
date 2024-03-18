class Notification < ApplicationRecord
    belongs_to :recipient, polymorphic: true
    belongs_to :sender, class_name: 'User'
    belongs_to :post
  end