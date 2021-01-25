RSpec.describe ServiceController, type: :controller do
  before do
    @service = FactoryBot.create(:service)
    sign_in joseane
  end

  describe "#show" do
    it "succeeds" do
      get :show, params: {id: @service.id }, format: :json
      expect(response).to be_successful
      expect(assigns(:service)).to eq(@service)
    end

    it "responds with 404 on a invalid id" do
      params = {id: @service.id }
      @service.destroy
      get :show, params: params, format: :json
      expect_status(404)
    end
  end

  describe "#create" do
    before do
      @params = {service: FactoryBot.attributes_for(:service)}
      @params[:value] = @params[:service][:value]
    end

    context "with valid params" do
      it "creates a service" do
        expect{ post :create, params: @params, format: :json }.to change(Service, :count).by(1)
      end

      it "responds with message" do
        post :create, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:value] = nil
      end

      it "does not create a service" do
        expect{ post :create, params: @params, format: :json }.not_to change(Service, :count)
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:value])
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
        id: @service.id,
        service: @service.to_hash.except(:id).merge(FactoryBot.attributes_for(:service).slice(:name))
      }

      @params[:value] = @params[:service][:value]
    end

    it "responds with 404 on a invalid id" do
      @service.destroy
      put :update, params: @params, format: :json
      expect_status(404)
    end

    context "with valid params" do
      it "doesn't overwrite random attributes" do
        category = @service.category
        put :update, params: @params, format: :json
        expect(@service.reload.category).to eq(category)
      end

      it "responds with message" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:value] = nil
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:value])
      end

      it "responds with 422" do
        post :create, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#index" do
    before do
      @services = FactoryBot.create_list(:service, 5)
    end

    it "succeeds" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of services" do
      get :index, format: :json
      expect(assigns(:services).map {|service| service.id}).to include(*(@services.map(&:id) << @service.id))
    end

    it "returns an empty array for no services" do
      get :index, format: :json
      Service.dataset.delete
      expect(assigns(:services).all).to eq([])
    end

    it "returns an array of services by filters " do
      service = FactoryBot.create(:service, name: "Medical X-Ray")
      get :index, params: { filter: {name: service.name} }, format: :json
      expect(assigns(:services).map {|service| service.id}).to contain_exactly(service.id)
    end
  end

  describe "#destroy" do
    it "destroys the service" do
      expect {
        delete :destroy, params: {id: @service.id}
      }.to change(Service, :count).by(-1)
    end
  end
end
