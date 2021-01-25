object @invoice

extends "invoice/_base"

attribute :patient

extends "invoice/_form"

child @invoice_services => :invoice_services do
  node do |att| {
      :id => att[:id],
      :name => att[:name],
      :reference_id => att[:reference_id],
      :value => att[:value],
      :service_value => att[:service_value]
    }
  end
end
