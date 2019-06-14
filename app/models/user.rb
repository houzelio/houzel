class User < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :devise
  plugin :delay_set_association
  devise :database_authenticatable, :registerable, :recoverable,
         :lockable, :lock_strategy => :none, :unlock_strategy => :none

  one_to_one :person, key: :owner_id

  before_validation :set_current_language, on: :create

  def set_current_language
   self.language = I18n.locale.to_s if self.language.blank?
 end
end
