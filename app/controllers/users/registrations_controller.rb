class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    super do |resource|
      resource.avatar.attach(params[:user][:avatar]) if params[:user][:avatar].present?
    end
  end

  protected

  def update_resource(resource, params)
    if resource.provider == 'google_oauth2'
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      super
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :avatar, :name, :secondname, :birth_date, :biography, :password, :password_confirmation, :current_password)
  end
  
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :name, :secondname, :birth_date, :biography, :password, :password_confirmation, :current_password, :avatar])
  end
end