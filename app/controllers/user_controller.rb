class UserController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def update
    @user = current_user

    if params[:password_params]
      change_password(user_params)
    else params[:email]
      change_email(user_params)
    end
  end

  def destroy
    if !params.dig(:user,:current_password) && current_user.admin?
      user = User[params[:id]]
      user.close_account!

      respond_with_message(I18n.t('user.messages.access_closed'), "success", :ok)
    else
      if !params.dig(:user,:current_password) && !current_user.admin?
        respond_with_message(I18n.t('general.messages.permission_denied'), "error", 401)
      end
    end
  end

  private

  def change_password(user_data)
    if @user.update_with_password(user_data)
      flash[:success] = I18n.t('user.messages.password_changed')
    else
      respond_with_message(I18n.t('user.messages.password_not_changed'), "error", 422)
    end
  end

  def change_email(user_data)
    if @user.update_fields(user_data, [:email])
      respond_with_message(I18n.t('user.messages.settings_updated'), "success", :ok)
    else
      respond_with @user
    end
  end

  def user_params
    params.require(:user).permit(:email).tap do |p|
      p[:current_password] = params.dig(:password_params, :current_password)
      p[:password] = params.dig(:password_params, :new_password)
      p[:password_confirmation] = params.dig(:password_params, :password_confirmation)
    end
  end
end
