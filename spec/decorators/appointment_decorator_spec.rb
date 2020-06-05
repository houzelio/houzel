RSpec.describe AppointmentDecorator do
  before do
    @appointment = FactoryBot.create(:visit, patient: sofia, examiner: joseane.person, schedule_appointment: true).appointment
    @appointment_decorator = AppointmentDecorator.new(@appointment)
  end

  context "localization" do
    describe "#date" do
      it "returns the date on appointment" do
        expect(@appointment_decorator.date).to eq(I18n.l(@appointment.start_date, format: :date))
      end
    end
  end

  describe "#start_time" do
    it "returns the start time on appointment" do
      expect(@appointment_decorator.start_time).to eq(@appointment.start_date.strftime("%H:%M"))
    end
  end

  describe "#end_time" do
    it "returns the end time on appointment" do
      expect(@appointment_decorator.end_time).to eq(@appointment.end_date.strftime("%H:%M"))
    end
  end

  describe "#patient_id" do
    it "returns the patient's id" do
      expect(@appointment_decorator.patient_id).to eq(sofia.id)
    end
  end

  describe "#examiner_id" do
    it "returns the examiner's id" do
      expect(@appointment_decorator.examiner_id).to eq(joseane.person_id)
    end
  end

  describe "#examiner_name" do
    it "returns the examiner's name" do
      expect(@appointment_decorator.examiner_name).to eq(joseane.person.name)
    end
  end
end
