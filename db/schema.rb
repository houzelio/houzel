Sequel.migration do
  change do
    create_table(:notification) do
      primary_key :id
      column :entity_id, "integer"
      column :entity_type, "character varying(127)"
      column :recipient_id, "integer"
      column :forget, "boolean", :default=>false, :null=>false
      column :description, "character varying(255)"
      column :type, "character varying(127)"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:entity_id], :name=>:index_notification_on_entity_id
      index [:entity_type, :entity_id], :name=>:index_notification_on_entity_type_and_entity_id
      index [:recipient_id], :name=>:index_notification_on_recipient_id
    end
    
    create_table(:patient) do
      primary_key :id
      column :name, "character varying(255)", :null=>false
      column :birthday, "date"
      column :sex, "character varying(63)"
      column :profession, "character varying(127)"
      column :site, "character varying(255)"
      column :address, "character varying(382)"
      column :zip_code, "character varying(63)"
      column :phone, "character varying(63)"
      column :email, "character varying(127)"
      column :parent_name, "character varying(255)"
      column :blood_type, "character varying(32)"
      column :observation, "text"
      column :removed_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:person) do
      primary_key :id
      column :guid, "text", :null=>false
      column :closed_account, "boolean", :default=>false
      column :owner_id, "integer"
      column :start_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:guid], :name=>:index_person_on_guid, :unique=>true
      index [:owner_id], :name=>:index_person_on_user_id
    end
    
    create_table(:schema_info) do
      column :version, "integer", :default=>0, :null=>false
    end
    
    create_table(:service) do
      primary_key :id
      column :name, "character varying(127)"
      column :category, "character varying(63)"
      column :value, "numeric", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:user) do
      primary_key :id
      column :email, "text", :default=>"", :null=>false
      column :encrypted_password, "text", :default=>"", :null=>false
      column :language, "text"
      column :reset_password_token, "text"
      column :reset_password_sent_at, "timestamp without time zone"
      column :remember_created_at, "timestamp without time zone"
      column :sign_in_count, "integer", :default=>0, :null=>false
      column :current_sign_in_at, "timestamp without time zone"
      column :last_sign_in_at, "timestamp without time zone"
      column :current_sign_in_ip, "inet"
      column :last_sign_in_ip, "inet"
      column :confirmation_token, "text"
      column :confirmed_at, "timestamp without time zone"
      column :confirmation_sent_at, "timestamp without time zone"
      column :unconfirmed_email, "text"
      column :authentication_token, "text"
      column :locked_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:confirmation_token], :unique=>true
      index [:email], :unique=>true
      index [:reset_password_token], :unique=>true
    end
    
    create_table(:invoice) do
      primary_key :id
      foreign_key :patient_id, :patient, :key=>[:id]
      column :bill_date, "timestamp without time zone"
      column :remarks, "character varying(255)"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:patient_id], :name=>:index_invoice_on_patient_id
    end
    
    create_table(:notification_actor) do
      primary_key :id
      foreign_key :notification_id, :notification, :key=>[:id], :on_delete=>:cascade
      column :person_id, "integer"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:notification_id], :name=>:index_notification_actor_on_notification_id
      index [:person_id], :name=>:index_notification_actor_on_person_id
    end
    
    create_table(:profile) do
      primary_key :id
      column :name, "character varying(255)", :null=>false
      column :birthday, "date"
      column :gender, "character varying(255)"
      column :location, "character varying(127)"
      column :phone, "character varying(63)"
      foreign_key :person_id, :person, :key=>[:id], :on_delete=>:cascade
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:role) do
      primary_key :id
      column :name, "character varying(63)", :null=>false
      foreign_key :person_id, :person, :key=>[:id], :on_delete=>:cascade
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
    end
    
    create_table(:visit) do
      primary_key :id
      column :status, "character varying(63)"
      foreign_key :patient_id, :patient, :key=>[:id]
      foreign_key :examiner_id, :person, :key=>[:id]
      column :start_date, "timestamp without time zone"
      column :end_date, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:examiner_id], :name=>:index_visit_on_examiner_id
      index [:patient_id], :name=>:index_visit_on_patient_id
    end
    
    create_table(:appointment) do
      primary_key :id
      column :description, "character varying(255)"
      foreign_key :visit_id, :visit, :key=>[:id], :on_delete=>:cascade
      column :start_date, "timestamp without time zone", :null=>false
      column :end_date, "timestamp without time zone", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:visit_id], :name=>:index_calendar_on_visit_id
    end
    
    create_table(:invoice_service) do
      primary_key :id
      column :name, "text", :null=>false
      column :value, "numeric", :null=>false
      foreign_key :invoice_id, :invoice, :key=>[:id], :on_delete=>:cascade
      foreign_key :reference_id, :service, :key=>[:id], :on_delete=>:set_null
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:name], :name=>:index_invoice_service_on_name
    end
    
    create_table(:medical_history) do
      primary_key :id
      column :complaint, "character varying(510)"
      column :diagnosis, "character varying(510)"
      column :notes, "text"
      foreign_key :visit_id, :visit, :key=>[:id], :on_delete=>:cascade
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:visit_id], :name=>:index_medical_history_on_visit_id
    end
  end
end
Sequel.migration do
  change do
    self << "SET search_path TO \"$user\", public"
    self << "INSERT INTO \"schema_info\" (\"version\") VALUES (1)"
  end
end
