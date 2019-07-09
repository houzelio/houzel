class Appointment < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  many_to_one :visit

  def validate
    super
    validates_presence :start_date
    validates_presence :end_date
  end
end
