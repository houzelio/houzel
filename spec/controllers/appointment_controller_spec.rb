RSpec.describe AppointmentController, type: :controller do
  let(:user) { luccas }

  before do
    @appointment = FactoryBot.create(:visit, patient: sofia, examiner: user.person, schedule_appointment: true).appointment
    sign_in user
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe "#show" do
    it "succeeds" do
      get :show, params: {id: @appointment.id }, format: :json
      expect(response).to be_successful
      expect(assigns(:appointment)).to eq(@appointment)
    end

    it "returns arrays of patients and examiners" do
      get :show, params: {id: @appointment.id }, format: :json
      expect(assigns(:patients).all).to all(be_an(Patient))
      expect(assigns(:examiners).all).to all(be_an(Person))
    end

    it "responds with 404 on a invalid id" do
      params = {id: @appointment.id }
      @appointment.destroy
      get :show, params: params, format: :json
      expect_status(404)
    end
  end

  describe "#create" do
    before do
      @params = {
        date: FFaker::Time.date,
        start_time: "09:30",
        end_time: "10:30"
      }

      @params = @params.merge({appointment: @params.merge({
        patient_id: sofia.id,
        examiner_id: user.person_id
      })})
    end

    context "with valid params" do
      it "creates an appointment" do
        expect{ post :create, params: @params, format: :json }.to change(Appointment, :count).by(1)
        expect(sofia.appointments.last.visit).to exist
      end

      it "responds with message" do
        post :create, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:appointment][:patient_id] = nil
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
        id: @appointment.id,
        date: @appointment.start_date.strftime('%Y/%m/%d'),
        start_time: "14:45",
        end_time: "15:30"
      }

      @params = @params.merge({
        appointment: @params.except(:id).merge(@appointment.visit.to_hash.slice(:patient_id, :examiner_id))
      })
    end

    it "responds with 404 on a invalid id" do
      @appointment.destroy
      put :update, params: @params, format: :json
      expect_status(404)
    end

    context "with valid params" do
      it "doesn't overwrite random attributes" do
        @params[:description] = FFaker::Lorem.paragraph
        put :update, params: @params, format: :json
        expect(@appointment.reload.description).to be_nil
      end

      it "responds with message" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end
    end

    context "with invalid params" do
      before do
        @params[:date] = @params[:appointment][:date] = nil
      end

      it "should return the errors" do
        post :create, params: @params, format: :json
        expect_json_keys('errors', [:appointment])
      end

      it "responds with 422" do
        post :create, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#new" do
    it "returns arrays of patients and examiners" do
      get :new, format: :json
      expect(assigns(:patients).all).to all(be_an(Patient))
      expect(assigns(:examiners).all).to all(be_an(Person))
    end
  end

  describe "#index" do
    before(:each) do
      FactoryBot.create_list(:visit, 3, patient: elijah, examiner: user.person, schedule_appointment: true)
    end

    it "succeeds" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns an array of appointments" do
      get :index, format: :json
      appointments = elijah.appointments
      expect(assigns(:appointments).decorated_collection.map {|appointment| appointment.id}).to include(*(appointments.map(&:id) << @appointment.id))
    end

    it "returns an empty array for no appointments" do
      get :index, format: :json
      Appointment.dataset.delete
      expect(assigns(:appointments).decorated_collection).to eq([])
    end

    it "returns an array of appointments by filters " do
      get :index, params: { filter: {name: sofia.name} }, format: :json
      expect(assigns(:appointments).decorated_collection.map {|appointment| appointment.id}).to contain_exactly(@appointment.id)
    end

    it "doesn't include appointments for checked visits" do
      elijah.visits_dataset.update(status: "checked")
      get :index, format: :json
      expect(Appointment.count).to eq(4)
      expect(assigns(:appointments).count).to eq(1)
    end
  end

  describe "#destroy" do
    it "destroys the appointment" do
      delete :destroy, params: {id: @appointment.id}
      expect(sofia.appointments).not_to include(@appointment)
    end
  end
end
