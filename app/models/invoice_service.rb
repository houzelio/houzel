class InvoiceService < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true

  many_to_one :service, key: :reference_id
  many_to_one :invoice
end
