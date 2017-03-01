Sequel.migration do
  change do
    create_table(:patient) do
      primary_key :id
      column :name, "character varying(255)", :null=>false
      column :birthday, "date"
      column :sex, "character varying(1)"
      column :profession, "character varying(127)"
      column :address, "character varying(382)"
      column :location, "character varying(127)"
      column :zip_code, "character varying(50)"
      column :phone, "character varying(63)"
      column :email, "character varying(127)"
      column :parent, "character varying(255)"
      column :blood_type, "character varying(5)"
      column :observation, "text"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:person) do
      primary_key :id
      column :guid, "text", :null=>false
      column :closed_account, "boolean", :default=>false
      column :start_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:guid], :name=>:index_person_on_guid, :unique=>true
    end
    
    create_table(:schema_info) do
      column :version, "integer", :default=>0, :null=>false
    end
  end
end
Sequel.migration do
  change do
    self << "SET search_path TO \"$user\", public"
    self << "INSERT INTO \"schema_info\" (\"version\") VALUES (1)"
  end
end
