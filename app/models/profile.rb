class Profile < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true

  many_to_one :person

  def validate
    super
    validates_presence :name, message: Sequel.lit(I18n.t("profile.messages.required_name")) 
    validates_format  /\A[^;]+\z/, [:name], :allow_blank => true
  end
end
