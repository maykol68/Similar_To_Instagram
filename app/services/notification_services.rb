class NotificationServices
  def self.notify(recipient, sender, message )
    Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message)
  end

  def self.notify_all_users_except(sender, message, post)
    User.where.not(id: sender.id).each do |recipient|
      Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message, post: post)
    end
  end
end