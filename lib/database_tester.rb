module DatabaseTester
  extend self

  def db
    Sequel::Model.db
  rescue Sequel::Error
    nil
  end
end
