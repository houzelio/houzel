Sequel.migration do
  change do

    create_table :person do
      primary_key :id
      column :guid,           String,     :null=>false
      column :closed_account, FalseClass, :default=>false
      column :owner_id,       Integer
      column :start_at,       DateTime
      column :created_at,     DateTime,   :null=>false
      column :updated_at,     DateTime,   :null=>false
    end

    add_index :person, [:guid], :name => 'index_person_on_guid', :using => :btree, :unique=>true
    add_index :person, [:owner_id], :name => 'index_person_on_user_id'

    create_table :patient do
      primary_key :id
      column :name,            String,   :null=>false, :size=>255
      column :birthday,        Date
      column :sex,             String,   :size=>63
      column :profession,      String,   :size=>127
      column :site,            String,   :size=>255
      column :address,         String,   :size=>382
      column :zip_code,        String,   :size=>63
      column :phone,           String,   :size=>63
      column :email,           String,   :size=>127
      column :parent_name,     String,   :size=>255
      column :blood_type,      String,   :size=>32

      column :observation,     String
      column :removed_at,      DateTime
      column :created_at,  DateTime, :null=>false
      column :updated_at,  DateTime, :null=>false
    end

    create_table :calendar do
      primary_key :id
      column :description, String, :size=>255
      column :start_date, DateTime, :null=>false
      column :end_date, DateTime, :null=>false
    end
  end
end
