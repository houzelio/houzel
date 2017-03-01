Sequel.migration do
  change do

    create_table :person do
      primary_key :id
      column :guid,           String,     :null=>false      
      column :closed_account, FalseClass, :default=>false
      column :start_at,       DateTime
      column :created_at,     DateTime,   :null=>false
      column :updated_at,     DateTime,   :null=>false
    end

    add_index :person, [:guid], :name => 'index_person_on_guid', :using => :btree, :unique=>true

    create_table :patient do
      primary_key :id
      column :name, String, :null=>false, :size=>255
      column :birthday, Date
      column :sex, String, :size=>1
      column :profession, String, :size=>127
      column :address, String, :size=>382
      column :location, String, :size=>127
      column :zip_code, String, :size=>50
      column :phone, String, :size=>63
      column :email, String, :size=>127
      column :parent, String, :size=>255
      column :blood_type, String, :size=>5
      column :observation, String
      column :created_at,  DateTime, :null=>false
      column :updated_at,  DateTime, :null=>false
    end
  end
end