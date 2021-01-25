object false

node(:total_count) { @services.pagination_record_count }

node :items do
	partial("service/_base", :object => @services)
end
