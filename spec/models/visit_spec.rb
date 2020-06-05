RSpec.describe Visit, type: :model do
  before do
    @visit = FactoryBot.build(:visit, examiner: joseane)
  end

  describe "validation" do
    describe "of patient" do
      it "requires a patient" do
        @visit.patient = nil
        expect(@visit).not_to be_valid
      end
    end

    describe "of examiner" do
      it "requires an examiner" do
        @visit.examiner = nil
        expect(@visit).not_to be_valid
      end
    end
  end
end
