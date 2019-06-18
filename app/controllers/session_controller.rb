class SessionController < Devise::SessionsController

  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    redirect_to after_sign_out_path_for(resource_name)
  end
end
