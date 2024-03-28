class NotificationServices
  def self.notify(recipient, sender, message )
    Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message)
  end

  def self.notify_follow(recipient, sender, message)
    Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message)
  end

  def self.notify_comments(recipient, sender, message, post)
    Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message, post: post)
  end

  def self.notify_likes(recipient, sender, message, post )
    Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message, post: post)
  end

  def self.notify_all_users_except(sender, message, post)
    User.where.not(id: sender.id).each do |recipient|
      Notification.create(recipient: recipient, recipient_type: 'User', sender: sender, message: message, post: post)
    end
  end
end