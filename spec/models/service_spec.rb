RSpec.describe Service, type: :model do
  before do
    @service = FactoryBot.build(:service)
  end

  describe "validation" do
    describe "of name" do
      it "requires a name" do
        @service.name = nil
        expect(@service).not_to be_valid
      end
    end

    describe "of value" do
      it "requires a value" do
        @service.value = nil
        expect(@service).not_to be_valid
      end
    end
  end
end
