class NotificationsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @notifications = current_user.notifications.order(created_at: :desc)
      
      # Marcar todas las notificaciones del usuario como leídas
      @notifications.each do |notification|
        notification.update(read: true)
      end
    end
  end