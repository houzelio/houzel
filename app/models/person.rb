class Person < Sequel::Model
  include Houzel::Guid

  plugin :timestamps, force: true, update_on_create: true
  plugin :delay_set_association

  many_to_one :user, key: :owner_id
  one_to_many :roles
  one_to_many :visits, key: :examiner_id
  one_to_one  :profile

  delegate :name, to: :profile

  def to_param
    self.guid
  end

  def lock_access!
    self.closed_account = true
    save_changes()
  end
end
