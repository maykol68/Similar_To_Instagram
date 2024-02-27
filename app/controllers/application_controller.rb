class ApplicationController < ActionController::Base
  include Pagy::Backend
  aurond_action :switch_locale
  before_action :authenticate_user!

    include Error


    def switch_locales(&action)
      I18n.with_locale(locale_from_header, &action)
    end
    private

    def locale_from_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    def authorize! record = nil
      is_allowed = if record 
        record.user_id == current_user.id
      else
        current_user.admin?
      end
      redirect_to posts_path, alert:t('common.not_authorized') unless is_allowed

    end
end
