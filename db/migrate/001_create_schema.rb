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
      column :created_at,      DateTime, :null=>false
      column :updated_at,      DateTime, :null=>false
    end

    create_table :service do
      primary_key :id
      column :name,            String,   :size=>127
      column :category,        String,   :size=>63  #"private; insurance"
      column :value,           Numeric,  :null=>false
      column :created_at,      DateTime, :null=>false
      column :updated_at,      DateTime, :null=>false
    end

    create_table :visit do
      primary_key :id
      column :status,        String,   :size=>63
      column :patient_id,    Integer
      column :specialist_id, Integer
      column :start_date,    DateTime
      column :end_date,      DateTime
      column :created_at,    DateTime, :null=>false
      column :updated_at,    DateTime, :null=>false
    end

    add_index :visit, [:patient_id],    :name => 'index_visit_on_patient_id'
    add_index :visit, [:specialist_id], :name => 'index_visit_on_specialist_id'

    create_table :appointment do
      primary_key :id
      column :description, String,   :size=>255
      column :visit_id,    Integer
      column :start_date,  DateTime, :null=>false
      column :end_date,    DateTime, :null=>false
      column :created_at,  DateTime, :null=>false
      column :updated_at,  DateTime, :null=>false
    end

    add_index :appointment, [:visit_id], :name => 'index_calendar_on_visit_id'

    create_table :medical_history do
      primary_key :id
      column :complaint,  String, :size=>510
      column :diagnosis,  String, :size=>510
      column :notes,      String
      column :visit_id,   Integer
      column :created_at, DateTime,   :null=>false
      column :updated_at, DateTime,   :null=>false
    end

    add_index :medical_history, [:visit_id], :name => 'index_medical_history_on_visit_id'

    create_table :invoice do
      primary_key :id
      column :patient_id, Integer
      column :bill_date,  DateTime
      column :remarks,    String,   :size=>255
      column :created_at, DateTime, :null=>false
      column :updated_at, DateTime, :null=>false
    end

    add_index :invoice, [:patient_id], :name => 'index_invoice_on_patient_id'

    create_table :invoice_service do
      primary_key :id
      column :name,         String,   :null=>false
      column :value,        Numeric,  :null=>false
      column :invoice_id,   Integer
      column :reference_id, Integer
      column :created_at,   DateTime, :null=>false
      column :updated_at,   DateTime, :null=>false
    end

    add_index :invoice_service, [:name], :name => 'index_invoice_service_on_name', :using=> :btree

    create_table :notification do
      primary_key :id
      column :entity_id,    Integer
      column :entity_type,  String,     :size=>127
      column :recipient_id, Integer
      column :forget,       FalseClass, :default=>false, :null=>false
      column :description,  String,     :size=>255
      column :type,         String,     :size=>127
      column :created_at,   DateTime,   :null=>false
      column :updated_at,   DateTime,   :null=>false
    end

    add_index :notification, [:entity_id], :name => 'index_notification_on_entity_id'
    add_index :notification, [:recipient_id], :name => 'index_notification_on_recipient_id'
    add_index :notification, [:entity_type, :entity_id], name: 'index_notification_on_entity_type_and_entity_id', using: :btree

    create_table :notification_actor do
      primary_key :id
      column :notification_id, Integer
      column :person_id,       Integer
      column :created_at,      DateTime, :null=>false
      column :updated_at,      DateTime, :null=>false
    end

    add_index :notification_actor, [:notification_id], :name => 'index_notification_actor_on_notification_id'
    add_index :notification_actor, [:person_id], :name => 'index_notification_actor_on_person_id', using: :btree

    alter_table :appointment do
      add_foreign_key [:visit_id], :visit, :null=>false
    end

    alter_table :visit do
      add_foreign_key [:patient_id],    :patient,  :null=>false
      add_foreign_key [:specialist_id], :person,   :null=>false
    end

    alter_table :invoice do
      add_foreign_key [:patient_id], :patient,  :null=>false
    end

    alter_table :invoice_service do
      add_foreign_key [:invoice_id], :invoice, :on_delete=>:cascade, :null=>false
      add_foreign_key [:reference_id], :service, :on_delete=>:set_null
    end

    alter_table :medical_history do
      add_foreign_key [:visit_id], :visit, :on_delete=>:cascade, :null=>false
    end

    alter_table :notification_actor do
      add_foreign_key [:notification_id], :notification, :on_delete=>:cascade, :null=>false
    end
  end
end
