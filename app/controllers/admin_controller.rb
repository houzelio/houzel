class AdminController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def users_role
    @users = UsersRole.new.users
  end

  class UsersRole
    using Sequel::SymbolAref

    def users
      r = User.select(:user[:id], :profile[:name], :role[:name].as(:role_name))
      r = r.association_join(person: :profile)
      r = r.left_join(:role, person_id: :person[:id])
      r = r.exclude(:closed_account)
      r
    end
  end
end
