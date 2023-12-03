# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:edit_email_password, :edit_profile]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def show
    @user = current_user
  end

  def edit_email_password
    @edit_email_password = true
    render :edit
  end

  def edit_profile
    @edit_email_password = false
    render :edit
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :bio, :avatar])
  end
end