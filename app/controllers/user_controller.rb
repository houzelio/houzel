class UserController < ApplicationController
  respond_to :json

  def destroy
    if !params.dig(:user,:current_password) && current_user.admin?
      user = User.first(id: params[:id])
      user.close_account!

      respond_with_message(I18n.t('user.messages.access_closed'), "success", :ok)
    else
      if !params.dig(:user,:current_password) && !current_user.admin?
        respond_with_message(I18n.t('general.messages.permission_denied'), "error", 401)
      end
    end
  end
end
