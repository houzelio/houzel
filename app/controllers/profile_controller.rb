class ProfileController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    @profile = ProfileDecorator.new(current_user.person.profile)
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
