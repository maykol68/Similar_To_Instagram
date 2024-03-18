class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true
      t.references :sender, foreign_key: { to_table: :users }
      t.text :message
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
