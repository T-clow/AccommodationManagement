# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update, :edit_profile, :update_profile]

  def update
    super
  end

  def after_update_path_for(resource)
    root_path
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    if current_user.update(account_update_params)
      redirect_to account_path, notice: 'プロフィールが更新されました。'
    else
      render :edit_profile
    end
  end

  def destroy
    super
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :bio, :avatar])
  end
end
