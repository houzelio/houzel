RSpec.describe VisitController, type: :controller do
  let(:user) { luccas }

  before do
    @visit = FactoryBot.create(:visit, patient: sofia, examiner: user.person)
    sign_in user
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe "#show" do
    it "succeeds" do
      get :show, params: {id: @visit.id }, format: :json
      expect(response).to be_successful
      expect(assigns(:visit)).to eq(@visit)
    end

    it "responds with 404 on a invalid id" do
      params = {id: @visit.id }
      @visit.destroy
      get :show, params: params, format: :json
      expect_status(404)
    end
  end

  describe "#create" do
    before do
      @params = {
        visit: FactoryBot.attributes_for(:visit).merge({
          patient_id: sofia.id
        })
      }
    end

    context "with valid params" do
      it "creates a visit" do
        expect{ post :create, params: @params, format: :json }.to change(Visit, :count).by(1)
        expect(sofia.visits.last.medical_history).to exist
      end

      it "responds with message" do
        post :create, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:visit][:patient_id] = nil
      end

      it "does not create a visit" do
        expect{ post :create, params: @params, format: :json }.not_to change(Visit, :count)
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
        id: @visit.id,
        visit: @visit.to_hash.except(:id).merge(end_date: @visit.start_date + 1.hour)
      }
    end

    it "responds with 404 on a invalid id" do
      @visit.destroy
      put :update, params: @params, format: :json
      expect_status(404)
    end

    it "doesn't overwrite random attributes" do
      @params[:examiner_id] = joseane.person_id
      put :update, params: @params, format: :json
      expect(@visit.reload.examiner_id).to eq(luccas.person_id)
    end

    it "responds with message" do
      put :update, params: @params, format: :json
      expect(response).to be_successful
      expect(assigns(:message)).not_to be_nil
    end
  end

  describe "#new" do
    it "returns an array of patients" do
      get :new, format: :json
      expect(assigns(:patients).all).to all(be_an(Patient))
    end
  end

  describe "#index" do
    before(:each) do
      @visits = FactoryBot.create_list(:visit, 5, status: 'checked')
    end

    it "succeeds" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of visits" do
      get :index, format: :json
      expect(assigns(:visits).decorated_collection.map {|visit| visit.id}).to include(*@visits.map(&:id))
    end

    it "returns an empty array for no visits" do
      get :index, format: :json
      Visit.dataset.delete
      expect(assigns(:visits).decorated_collection).to eq([])
    end

    it "returns an array of visits by filters " do
      visit = FactoryBot.create(:visit, patient: elijah, examiner: user.person, status: 'checked')
      get :index, params: { filter: {name: elijah.name} }, format: :json
      expect(assigns(:visits).decorated_collection.map {|visit| visit.id}).to contain_exactly(visit.id)
    end

    it "doesn't include not checked visits" do
      get :index, format: :json
      expect(Visit.count).to eq(6)
      expect(assigns(:visits).count).to eq(5)
    end
  end

  describe "#destroy" do
    it "destroys the visit" do
      delete :destroy, params: {id: @visit.id}
      expect(sofia.visits).not_to include(@visit)
    end
  end
end
