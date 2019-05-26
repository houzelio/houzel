class Patient < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true

  def validate
    super
    validates_max_length 255, :name
    validates_max_length 63,  :phone
    validates_max_length 127, :email
    validates_max_length 255, :site
    validates_max_length 63,  :zip_code
    validates_max_length 255, :address
    validates_max_length 127, :profession
    validates_max_length 255, :parent_name
  end
end
