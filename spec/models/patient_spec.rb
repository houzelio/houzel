RSpec.describe Patient, type: :model do
  before do
    @patient = FactoryBot.build(:patient)
  end

  describe "validation" do
    describe "of name" do
      it "requires a name" do
        @patient.name = nil
        expect(@patient).not_to be_valid
      end
    end
  end
end
