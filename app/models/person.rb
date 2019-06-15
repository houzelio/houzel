class Person < Sequel::Model
  include Houzel::Guid

  plugin :timestamps, force: true, update_on_create: true

  many_to_one :user, key: :owner_id
  one_to_one  :profile

  delegate :name, :to => :profile

  def to_param
    self.guid
  end

end
