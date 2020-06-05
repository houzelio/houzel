RSpec.describe ProfileDecorator do
  before do
    @profile = luccas.person.profile
    @profile_decorator = ProfileDecorator.new(@profile)
  end

  describe "#birthday" do
    it "returns the birthday formated by locale" do
      expect(@profile_decorator.birthday).to eq(I18n.l(@profile.birthday))
    end
  end
end
