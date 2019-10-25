class ProfileDecorator < ApplicationDecorator
  delegate_all

  def birthday
    I18n.l(profile.birthday) if profile.birthday
  end
end
