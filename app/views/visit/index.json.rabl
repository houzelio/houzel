object false

node(:total_count) { @visits.pagination_record_count }

child @visits => :items do
  extends "visit/_base"

  attributes :start_date_long

  node do |att| {
    :patient_name => att[:name],
    :sex => att[:sex]
   }
  end
end
