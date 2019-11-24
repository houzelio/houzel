class Patient < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :many_through_many

  one_to_many :visit
  one_to_many :invoice
  many_through_many :appointment, [[:visit, :patient_id, :id]], right_primary_key: :visit_id

  def validate
    super
    validates_presence :name
  end
end
