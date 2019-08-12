class Service < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
end
