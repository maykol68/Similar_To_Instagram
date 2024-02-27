module Error
    extend ActiveSupport::Concern

    included do
        rescue_from ActiveRecord::RecordNotFound do
            redirect_to root_path, alert: t('Not_Found')
        end
    end
end