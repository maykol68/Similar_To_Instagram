class AddPostToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :post, null: true, foreign_key: false
  end
end
