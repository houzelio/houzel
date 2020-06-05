RSpec.describe User, type: :model do
  before do
    @user = joseane
  end

  describe "validation" do
    describe "of email" do
      it "requires an email" do
        @user.email = nil
        expect(@user).not_to be_valid
      end

      it "requires a unique email address" do
        @user.email = luccas.email
        expect(@user).not_to be_valid
     end

     it "requires a valid email address" do
       @user.email = "myhouzelemail"
       expect(@user).not_to be_valid
     end
    end

    describe "of password" do
      it "requires an email" do
        user = FactoryBot.build(:user, password: nil)
        expect(user).not_to be_valid
      end

      it "requires a minimum length" do
        user = FactoryBot.build(:user, password: "passw")
        expect(user).not_to be_valid
      end
    end

    describe "of language" do
      after do
        I18n.locale = :en
      end

      it "requires available codes" do
        @user.language = "invalid language"
        expect(@user).not_to be_valid
      end

      it "saves with current language if blank" do
        I18n.locale = "pt-BR"
        user = FactoryBot.create(:user, password: 'password', password_confirmation: 'password')
        expect(user.language).to eq("pt-BR")
      end

      it "saves with language what is set" do
        I18n.locale = :en
        user = FactoryBot.create(:user, password: 'password', password_confirmation: 'password', language: "pt-BR")
        expect(user.language).to eq("pt-BR")
      end
    end
  end

  describe "#admin?" do
    it "returns whether it's an admin or not" do
      expect(@user.admin?).to be_falsy

      @user.person.add_role(Role.new(name: "admin"))
      expect(@user.admin?).to be_truthy
    end

    it "should call Role#is_admin?" do
      expect(Role).to receive(:is_admin?).with(@user.person)
      @user.admin?
    end
  end

  describe "#close_account!" do
    it "locks the user out" do
      @user.close_account!
      expect(@user.reload.access_locked?).to be true
    end

    it "should call person#lock_access!" do
      expect(@user.person).to receive(:lock_access!)
      @user.close_account!
    end
  end
end
