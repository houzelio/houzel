class Role < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :def_dataset_method

  many_to_one :person

  subset(:admins, name: "admin")

  def self.is_admin?(person)
    first(person: person, name: ["admin", "owner"]).present?
  end

  def self.add_admin(person)
    find_or_create(person: person, name: "admin")
  end

  def self.has_owner?
    first(name: "owner").present?
  end

  def self.is_owner?(person)
    first(person: person).present?
  end
end
