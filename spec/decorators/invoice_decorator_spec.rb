RSpec.describe InvoiceDecorator do
  before do
    @invoice = FactoryBot.create(:invoice, bill_date: FFaker::Time.datetime.to_datetime)
    @invoice_decorator = InvoiceDecorator.new(@invoice)
  end

  describe "#bill_date" do
    it "returns the bill date on invoice" do
      expect(@invoice_decorator.bill_date).to eq(I18n.l(@invoice.bill_date, format: :date))
    end
  end
end
