class MedicalHistory < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  many_to_one :visit

  delegate :start_date, :end_date, to: :visit
end
