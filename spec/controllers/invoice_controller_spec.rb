RSpec.describe InvoiceController, type: :controller do
  before do
    @invoice = FactoryBot.create(:invoice, patient: sofia)
    @invoice.add_invoice_service(InvoiceService.new(FactoryBot.attributes_for(:service).except(:category)))
    sign_in joseane
  end

  describe "#show" do
    before do
      FactoryBot.create_list(:service, 2)
    end

    it "succeeds" do
      get :show, params: {id: @invoice.id }, format: :json
      expect(response).to be_successful
      expect(assigns(:invoice)).to eq(@invoice)
    end

    it "returns arrays of services and invoice services" do
      get :show, params: {id: @invoice.id }, format: :json
      expect(assigns(:services).all).to all(be_an(Service))
      expect(assigns(:invoice_services).all).to all(be_an(InvoiceService))
    end

    it "responds with 404 on a invalid id" do
      params = {id: @invoice.id }
      @invoice.destroy
      get :show, params: params, format: :json
      expect_status(404)
    end
  end

  describe "#create" do
    before do
      @params = {
        invoice: FactoryBot.attributes_for(:invoice).merge(patient_id: elijah.id),
        invoice_services:[
          FactoryBot.attributes_for(:service).except(:category),
          FactoryBot.attributes_for(:service).except(:category)
        ]
      }

    end

    context "with valid params" do
      it "creates an invoice" do
        expect{ post :create, params: @params, format: :json }.to change(Invoice, :count).by(1)
      end

      it "responds with message" do
        post :create, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:invoice][:patient_id] = nil
      end

      it "does not create a visit" do
        expect{ post :create, params: @params, format: :json }.not_to change(Invoice, :count)
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:patient_id])
      end

      it "responds with 422" do
        post :create, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#update" do
    before do
      @params = {
        id: @invoice.id,
        invoice: @invoice.to_hash.except(:id),
        invoice_services: [FactoryBot.attributes_for(:service).except(:category)]
      }
    end

    it "responds with 404 on a invalid id" do
      @invoice.destroy
      put :update, params: @params, format: :json
      expect_status(404)
    end

    context "with valid params" do
      it "doesn't overwrite random attributes" do
        put :update, params: @params, format: :json
        expect(@invoice.reload.patient_id).to eq(sofia.id)
      end

      it "responds with message" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:invoice][:patient_id] = nil
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:patient_id])
      end

      it "responds with 422" do
        post :create, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#new" do
    it "returns arrays of patients and services" do
      get :new, format: :json
      expect(assigns(:patients).all).to all(be_an(Patient))
      expect(assigns(:services).all).to all(be_an(Service))
    end
  end

  describe "#index" do
    it "succeeds" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of invoices" do
      get :index, format: :json
      expect(assigns(:invoices).decorated_collection.map {|invoice| invoice.id}).to contain_exactly(@invoice.id)
    end

    it "returns an empty array for no invoices" do
      get :index, format: :json
      Invoice.dataset.delete
      expect(assigns(:invoices).decorated_collection).to eq([])
    end

    it "returns an array of invoices by filters " do
      invoice = FactoryBot.create(:invoice, patient: elijah)
      get :index, params: { filter: {name: elijah.name} }, format: :json
      expect(assigns(:invoices).decorated_collection.map {|invoice| invoice.id}).to contain_exactly(invoice.id)
    end
  end

  describe "#destroy" do
    it "destroys the invoice" do
      delete :destroy, params: {id: @invoice.id}
      expect(sofia.invoices).not_to include(@invoice)
    end
  end
end
