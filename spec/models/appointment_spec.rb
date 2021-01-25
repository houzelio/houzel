RSpec.describe Appointment, type: :model do
  before do
    @appointment = FactoryBot.build(:appointment)
  end

  describe "validation" do
    describe "of start_date" do
      it "requires a date" do
        @appointment.start_date = nil
        expect(@appointment).not_to be_valid
      end
    end

    describe "of end_date" do
      it "requires a date" do
        @appointment.end_date = nil
        expect(@appointment).not_to be_valid
      end
    end
  end
end
