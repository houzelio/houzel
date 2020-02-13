module DatabaseTester
  def self.has_connection?
    Sequel::Model.db.present?
  rescue Sequel::Error
    false
  end
end
