class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Error
  include Language
  before_action :authenticate_user!

    

    def authorize! record = nil
      is_allowed = if record 
        record.user_id == current_user.id
      else
        current_user.admin?
      end
      redirect_to posts_path, alert:t('common.not_authorized') unless is_allowed

    end
end
