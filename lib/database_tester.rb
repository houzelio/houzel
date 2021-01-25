module DatabaseTester
  extend self

  def db
    Sequel::Model.db
  rescue Sequel::Error
    nil
  end

  def tbl_exists?(name)
    db.present? && db.table_exists?(name)
  end
end
