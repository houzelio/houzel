class ProfileController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    @profile = ProfileDecorator.new(current_user.person.profile)
  end

  def update
    changed_language = current_user.update_fields({ language: params[:locale] }, [:language])

    profile = Profile.first(id: params[:id])
    if profile.update_fields(profile_params, profile_fields) || changed_language
      render json: { path: profile_index_path }, :status => :ok
    else
      respond_with profile
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :name, :birthday, :location, :phone
    )
  end

  def profile_fields
    [:name, :birthday, :location, :phone]
  end
end
