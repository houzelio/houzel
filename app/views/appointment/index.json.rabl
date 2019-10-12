object false

node(:total_count) { @appointments.pagination_record_count }

child @appointments => :items do
  extends "appointment/_base"

  attributes :examiner_name

  node do |att| {
    :patient_name => att[:name]
   }
  end
end
