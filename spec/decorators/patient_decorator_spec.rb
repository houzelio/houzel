RSpec.describe PatientDecorator do
  before do
    @patient = FactoryBot.create(:patient)
    @patient_decorator = PatientDecorator.new(@patient)
  end

  describe "#birthday" do
    it "returns the birthday formated by locale" do
      expect(@patient_decorator.birthday).to eq(I18n.l(@patient.birthday))
    end
  end

  describe "#scheduled_appointments" do
    before do
      FactoryBot.create_list(:visit, 4, patient: @patient, schedule_appointment: true)
    end

    it "returns nil for a scope differ from 'extended'" do
      expect(@patient_decorator.scheduled_appointments).to be_nil
    end

    it "returns a decorated array of scheduled appointments" do
      patient_decorator = PatientDecorator.new(@patient, context: {scope: 'extended'})
      expect(patient_decorator.scheduled_appointments).to be_decorated
    end
  end
end
