class Service < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true

  one_to_many :invoice_service
end
