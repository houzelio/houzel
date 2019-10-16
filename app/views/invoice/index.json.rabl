object false

node(:total_count) { @invoices.pagination_record_count }

child @invoices => :items do
  extends "invoice/_base" 

  node do |att| {
    :patient_name => att[:name]
   }
  end
end
