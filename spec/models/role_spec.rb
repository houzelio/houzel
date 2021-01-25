RSpec.describe Role, type: :model do
  before do
    @person = FactoryBot.create(:person)
    @admin = FactoryBot.create(:person)
    @admin.add_role(name: "admin")
  end

  describe "subset" do
    describe ".admins" do
      it "returns admins roles" do
        expect(Role.admins).to match_array(@admin.roles)
      end
    end
  end

  describe ".is_admin?" do
    it "defaults to false" do
      expect(Role.is_admin?(@person)).to be_falsy
    end

    it "returns true when the user is an admin" do
      expect(Role.is_admin?(@admin)).to be_truthy
    end
  end

  describe ".add_admin" do
    it "creates the admin role" do
      Role.add_admin(@person)
      expect(@person.roles_dataset.where(name: "admin").first).to exist
    end
  end
end
