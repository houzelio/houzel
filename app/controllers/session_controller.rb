class SessionController < Devise::SessionsController
  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { render json: {}, :status => 401}
    end
  end
end
