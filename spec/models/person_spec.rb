RSpec.describe Person, type: :model do
  before do
    @person = luccas.person
  end

  describe "#lock_access!" do
    it "sets the closed_account flag" do
      @person.lock_access!
      expect(@person.reload.closed_account).to be true
    end
  end
end
