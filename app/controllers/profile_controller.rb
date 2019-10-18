class ProfileController < ApplicationController
  before_action :authenticate_user!

  respond_to :json


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
