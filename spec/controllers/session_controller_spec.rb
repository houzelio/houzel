RSpec.describe SessionController, type: :controller do
  describe "#destroy" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in joseane
    end

    it "redirects to /" do
      delete :destroy
      expect(response).to redirect_to new_user_session_path
    end
  end
end
