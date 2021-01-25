RSpec.describe UserController, type: :controller do
  before do
    @user = FactoryBot.create(:user, password: "blop1n4", password_confirmation: "blop1n4")
    sign_in @user
    allow(@controller).to receive(:current_user).and_return(@user)
  end

  describe "#update" do
    before do
      @params = {
        id: @user.id,
        user: {
          language: "pt-BR"
        }
      }
    end

    it "doesn't overwrite random attributes" do
      expect {
        put :update, params: @params, format: :json
      }.not_to change(@user, :language)
    end

    describe "password" do
      before do
        @password_params = {
          current_password: "blop1n4",
          new_password: "foobarz",
          password_confirmation: "foobarz"
        }

        @params = @params.merge({
          password_params: @password_params
        })

      end

      it "updates using devise's with password" do
        password_params = ActionController::Parameters.new(@password_params.merge(password: "foobarz").except(:new_password))
        password_params = password_params.permit([:current_password, :password, :password_confirmation])
        expect(@user).to receive(:update_with_password).with(password_params).and_return(@user)
        put :update, params: @params, format: :json
      end

      it "returns a message over invalid password" do
        @params[:password_params][:current_password] = "_blop1n4"
        put :update, params: @params, format: :json
        expect(assigns(:message)).not_to be_nil
      end
    end

    describe "email" do
      before do
        @params = @params.merge(
          user: {
            email: FFaker::Internet.email
          }
        )
      end

      it "responds with message" do
        put :update, params: @params, format: :json
        expect(response).to be_successful
        expect(assigns(:message)).not_to be_nil
      end

      it "responds with 422 over failure" do
        @params[:user][:email] = "myemail"
        put :update, params: @params, format: :json
        expect_status(422)
      end
    end
  end

  describe "#destroy" do
    describe"when it's an admin" do
      before do
        @params = { id: luccas.id }

        Role.add_admin(@user.person)
        @person = luccas.person
      end

      it 'closes an user account' do
        delete :destroy, params: @params
        expect(@person.reload.closed_account).to be_truthy
      end

      it 'does nothing if the user is the owner' do
        luccas.person.add_role(Role.new(name: "owner"))
        delete :destroy, params: @params
        expect(@person.reload.closed_account).to be_falsy
      end
    end
  end
end
