class Visit < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :delay_set_association
  plugin :nested_association

  many_to_one :patient
  one_to_one  :appointment
  one_to_one  :medical_history

  nested_association :appointment
  nested_association :medical_history
end
