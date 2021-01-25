class UserDecorator < ApplicationDecorator
  delegate :email

  def name
    user.person.name
  end

  def as_json(*args)
    {
      email: email,
      name: name,
      admin: admin
    }
  end

  def admin
    user.admin?
  end
end
