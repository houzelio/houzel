class Patient < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :many_through_many

  one_to_many :visits
  one_to_many :invoices
  many_through_many :appointments, [[:visit, :patient_id, :id]], right_primary_key: :visit_id

  def validate
    super
    validates_presence :name
  end

  def scheduled_appointments
    appointments_dataset.where(status: "scheduled").all
  end
end
