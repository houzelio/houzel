RSpec.describe PatientController, type: :controller do
  before do
    @patient = sofia
    sign_in joseane
  end

  describe "#show" do
    it "succeeds" do
      get :show, params: {id: @patient.id }, format: :json
      expect(response).to be_successful
      expect(assigns(:patient)).to eq(@patient)
    end

    it "responds with 404 on a invalid id" do
      params = {id: @patient.id }
      @patient.destroy
      get :show, params: params, format: :json
      expect_status(404)
    end
  end

  describe "#create" do
    before do
      @params = {patient: FactoryBot.attributes_for(:patient)}
    end

    context "with valid params" do
      it "creates a patience" do
        expect{ post :create, params: @params, format: :json }.to change(Patient, :count).by(1)
      end

      it "responds with message" do
        post :create, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:patient][:name] = nil
      end

      it "does not create a patient" do
        expect{ post :create, params: @params, format: :json }.not_to change(Patient, :count)
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:name])
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
        id: @patient.id,
        patient: @patient.to_hash.except(:id).merge(parent_name: FFaker::Name.name)
      }
    end

    it "responds with 404 on a invalid id" do
      @patient.destroy
      put :update, params: @params, format: :json
      expect_status(404)
    end

    context "with valid params" do
      it "doesn't overwrite random attributes" do
        name = sofia.name
        put :update, params: @params, format: :json
        expect(@patient.reload.name).to eq(name)
      end

      it "responds with message" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:patient][:name] = nil
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:name])
      end

      it "responds with 422" do
        post :create, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#index" do
    before do
      @patients = FactoryBot.create_list(:patient, 5)
    end

    it "succeeds" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of patients" do
      get :index, format: :json
      expect(assigns(:patients).map {|patient| patient.id}).to include(*(@patients.map(&:id) << @patient.id))
    end

    it "returns an empty array for no patients" do
      get :index, format: :json
      Patient.dataset.delete
      expect(assigns(:patients).all).to eq([])
    end

    it "returns an array of patients by filters " do
      patient = FactoryBot.create(:patient, name: "Suzana Herculano-Houzel")
      get :index, params: { filter: {name: patient.name} }, format: :json
      expect(assigns(:patients).map {|patient| patient.id}).to contain_exactly(patient.id)
    end
  end

  describe "#destroy" do
    it "destroys the patient" do
      delete :destroy, params: {id: @patient.id}
      expect(Patient[@patient.id]).to be_nil
    end
  end
end
