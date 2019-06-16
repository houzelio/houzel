class RegistrationController < Devise::RegistrationsController
  include LayoutHelper

  def create
    @user = User.new
    @user.set_fields(user_params, user_fields)

    profile = Profile.new
    profile.set_fields(params.permit(:name), [:name])
    @user.person = Person.new(profile: profile)

    if @user.save()
      unless Role.has_owner?
        @user.person.add_role(Role.new(name: "owner"))
      end

      sign_in_and_redirect(:user, @user)
    else
      flash.now[:error] = @user.errors.full_messages.join("<br/>").html_safe
      render action: "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation
    )
  end

  def user_fields
    [:email, :password, :password_confirmation]
  end
end
