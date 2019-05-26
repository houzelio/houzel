class Person < Sequel::Model
  include Houzel::Guid

  plugin :timestamps, force: true, update_on_create: true

  def to_param
    self.guid
  end

end
