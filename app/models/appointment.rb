class Appointment < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  many_to_one :visit
end
