class ApplicationController < ActionController::Base

    include Error

    private

    def authorize! record = nil
      is_allowed = if record 
        record.user_id == Current.user.id
      else
        Current.user.admin?
      end
      redirect_to posts_path, alert:t('common.not_authorized') unless is_allowed

    end
end
