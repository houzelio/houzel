class User < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :devise
  plugin :delay_set_association
  devise :database_authenticatable, :registerable, :recoverable,
         :lockable, :lock_strategy => :none, :unlock_strategy => :none

  one_to_one :person, key: :owner_id

end
