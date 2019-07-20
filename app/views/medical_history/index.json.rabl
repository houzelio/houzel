object false

node(:total_count) { @mcl_histories.pagination_record_count }

node :items do
	partial("medical_history/_base", :object => @mcl_histories)
end
