RSpec.describe RegistrationController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#create" do
    before do
      @params = {
        name: FFaker::Name.name,
        user:{
          email: "myaccount@houzel.com",
          password: "blop1n4",
          password_confirmation: "blop1n4"
        }
      }
    end

    context "with valid parameters" do
      it "creates an user" do
        expect {
         get :create, params: @params
       }.to change(User, :count).by(1)
      end

      it "assigns @user" do
        get :create, params: @params
        expect(assigns(:user)).to be_truthy
      end
    end

    context "with invalid parameters" do
      before do
        @params[:name] = nil
      end

      it "does not create an user" do
        expect {
          get :create, params: @params
        }.not_to change(User, :count)
      end

      it "does not create a person" do
        expect {
          get :create, params: @params
        }.not_to change(Person, :count)
      end

      it "sets the flash error" do
        get :create, params: @params
        expect(flash[:error]).not_to be_blank
      end

      it "renders new" do
        get :create, params: @params
        expect(response).to render_template("layouts/application", "registrations/new")        
      end
    end
  end
end
