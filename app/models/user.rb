class User < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :devise
  plugin :delay_set_association
  devise :database_authenticatable, :registerable, :recoverable,
         :lockable, :lock_strategy => :none, :unlock_strategy => :none

  one_to_one :person, key: :owner_id

  before_validation :set_current_language, on: :create

  def validate
    validates_presence :email, message: Sequel.lit(I18n.t("user.messages.required_email"))
    if email_changed?
      validates_unique :email, allow_blank: true, message: Sequel.lit(I18n.t("user.messages.changed_email"))
      validates_format Devise.email_regexp, :email, allow_blank: true, message: Sequel.lit(I18n.t("user.messages.email_format"))
    end

    validates_presence :password, message: Sequel.lit(I18n.t("user.messages.required_password"))
    validates_length_range Devise.password_length, :password, allow_blank: true, message: Sequel.lit(I18n.t("user.messages.password_format"))

    validates_includes AVAILABLE_LANGUAGE_CODES, :language
  end

  def set_current_language
   self.language = I18n.locale.to_s if self.language.blank?
 end

 def close_account!
   person.lock_access!
   self.lock_access!
 end
end
