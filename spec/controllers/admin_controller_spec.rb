RSpec.describe AdminController, type: :controller do
  describe "#users_role" do
    before do
      @users = FactoryBot.create_list(:user, 2)
      sign_in luccas
      luccas.person.add_role(Role.new(name: "owner"))
    end

    it "returns users accounts with role name" do
      get :users_role, format: :json
      expect(assigns(:users).map {|user| user.id}).to include(*(@users.map(&:id) << luccas.id))
      expect(assigns(:users).first).to include(:role_name)
    end

    it "doesn't return closed users accounts" do
      user = @users[0]
      user.close_account!

      get :users_role, format: :json
      expect(assigns(:users).map {|user| user.id}).not_to contain_exactly(user.id)
    end
  end
end
