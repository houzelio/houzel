object @patient

extends "patient/_base"

child :scheduled_appointments => :appointments  do
  attributes :date, :examiner_name, :visit_id
end
