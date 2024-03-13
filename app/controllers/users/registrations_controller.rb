class Users::RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if resource.provider == 'google_oauth2'
      params.delete('current_password')
      resource.password = params['password']
      resource.ivebeenupdated = true
      resource.update_without_password(params)
    else
      super
    end
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end