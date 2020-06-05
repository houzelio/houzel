RSpec.describe ProfileController, type: :controller do
  let(:user) {joseane}

  before do
    sign_in user
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe "#show" do
    it "succeeds" do
      get :show, format: :json
      expect(response).to be_successful
      expect(assigns(:profile)).to eq(user.person.profile)
    end
  end

  describe "#update" do
    before do
      @profile = user.person.profile
      @params = {
        id: @profile.id,
        locale: user.language,
        profile: FactoryBot.attributes_for(:profile).except(:gender)
      }
    end

    context "with valid params" do
      it "doesn't overwrite random attributes" do
        gender = @profile.gender
        put :update, params: @params, format: :json
        expect(@profile.reload.gender).to eq(gender)
      end

      it "returns ok" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      before do
        @params[:profile][:name] = nil
      end

      it "should return the errors" do        
        post :update, params: @params, format: :json
        expect_json_keys('errors', [:name])
      end
    end
  end
end
