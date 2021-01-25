object false

node(:total_count) { @patients.pagination_record_count }

node :items do
	partial("patient/_base", :object => @patients)
end
