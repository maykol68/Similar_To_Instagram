module Error
    extend ActiveSupport::Concern

    include do
        
        rescue_from ActiveRecord::RecordNotFound do
            redirect_to posts_path, alert: t('Not_Found')
        end
    end
end