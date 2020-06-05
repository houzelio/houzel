RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile, person: FactoryBot.create(:person))
  end

  describe "validation" do
    describe "of name" do
      it "requires a name" do
        @profile.name = nil
        expect(@profile).not_to be_valid
      end

      it "cannot contain ;" do
        @profile.name = "Squ;are"
        expect(@profile).not_to be_valid
      end
    end
  end
end
