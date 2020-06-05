RSpec.describe Invoice, type: :model do
  before do
    @invoice = FactoryBot.create(:invoice, patient: elijah)
  end

  describe "#add_invoice_services" do
    before do
      @services = FactoryBot.create_list(:service, 2)
      @invoice_services_params = [
        ActionController::Parameters.new(@services[0].to_hash.slice(:name, :value).merge(reference_id: @services[0].id)),
        ActionController::Parameters.new({name: "Visit#0912", value: "98.00", refenrence_id: nil}),
        ActionController::Parameters.new(@services[1].to_hash.slice(:name, :value).merge(reference_id: @services[1].id))
      ]

      @invoice_service = FactoryBot.build(:invoice_service, value: "99.00", invoice: @invoice)
    end

    it "adds invoice services to invoice" do
      @invoice.add_invoice_services(@invoice_services_params)
      expect { @invoice.save }.to change(InvoiceService, :count).by(3)
    end

    it "changes an invoice service value" do
      @invoice_service.save
      @invoice.add_invoice_services([ActionController::Parameters.new({id: @invoice_service.id, value: "99.99"})])
      @invoice.save
      expect(Houzel::Money.simple_value(@invoice_service.reload.value)).to eq("99.99")
    end

    it "remove unlisted invoice services" do
      @invoice_service.save
      @invoice.add_invoice_services(@invoice_services_params[0, 0])
      expect(@invoice.invoice_services.map {|invoice_service| invoice_service.id}).not_to include(@invoice.id)
    end

    it "removes all invoices services after an empty array" do
      @invoice.add_invoice_services(@invoice_services_params)
      @invoice.save
      @invoice.add_invoice_services([])
      @invoice.save
      expect(@invoice.invoice_services).to eq([])
    end
  end

  describe "#total" do
    before do
      FactoryBot.create_list(:invoice_service, 3, value: "99.00", invoice: @invoice)
    end

    it "gets invoice total" do
      expect(Houzel::Money.simple_value(@invoice.total)).to eq("297.00")
    end
  end
end
