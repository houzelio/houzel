RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      head :ok
    end
  end

  before do
    sign_in luccas
  end

  describe "#after_sign_in_path_for" do
    it "redirects to root " do
      expect(@controller.send(:after_sign_in_path_for, luccas)).to eq(root_path)
    end
  end

  describe "#after_sign_out_path_for" do
    it "handles the request after a sign-out" do
      expect(@controller.send(:after_sign_out_path_for, luccas)).to eq(new_user_session_path)
    end
  end
end
