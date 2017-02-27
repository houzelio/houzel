class Person < Sequel::Model
  include Houzel::Guid

  def to_param
    self.guid
  end

end
