RSpec.describe VisitDecorator do
  before do
    @visit = FactoryBot.create(:visit, patient: sofia, examiner: joseane.person)
    @visit_decorator = AppointmentDecorator.new(@visit)
  end

  context "localization" do
    describe "#start_date" do
      it "returns the start date on visit" do
        expect(@visit_decorator.start_date).to eq(I18n.l(@visit.start_date, format: :datetime))
      end
    end

    describe "#end_end" do
      it "returns nil for an unchecked-out visit" do
        expect(@visit_decorator.end_date).to be_nil
      end

      it "returns the end date on visit" do
        @visit.update(end_date: @visit.start_date + 1.day)        
        expect(@visit_decorator.end_date).to eq(I18n.l(@visit.end_date, format: :datetime))
      end
    end

    describe "#start_date_long" do
      it "returns the start date on visit formatted with long format" do
        expect(@visit_decorator.start_date).to eq(I18n.l(@visit.start_date, format: :long))
      end
    end
  end

  describe "#history" do
    it "returns the medical history of visit" do
      expect(@visit_decorator.medical_history).to exist
    end
  end
end
