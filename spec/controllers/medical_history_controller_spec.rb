RSpec.describe MedicalHistoryController, type: :controller do

  describe "#index" do
    before do
      @visits = FactoryBot.create_list(:visit, 2, patient: sofia)
      sign_in joseane
      @params = { patient_id: sofia.id }
    end

    it "succeeds" do
      get :index, params: @params, format: :json
      expect(response).to be_successful
    end

    it "returns an array of medical histories for patient" do
      get :index, params: @params, format: :json
      expect(assigns(:mcl_histories).map {|mcl_history| mcl_history.visit.patient_id}).to include(sofia.id)
    end

    it "gets the patient from a visit and returns his medical histories" do
      visits = FactoryBot.create_list(:visit, 3, patient: elijah)
      get :index, params: {visit_id: visits[0].id}, format: :json
      expect(assigns(:mcl_histories).map {|mcl_history| mcl_history.visit.patient_id}).to include(elijah.id)
    end

    it "returns an empty array for no medical history" do
      get :index, params: @params, format: :json
      Visit.where(patient_id: sofia.id).delete
      expect(assigns(:mcl_histories).all).to eq([])
    end
  end
end
