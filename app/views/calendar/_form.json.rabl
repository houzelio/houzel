object @calendar

extends "calendar/_base"

child @patients => :patient_collection do
  attributes :id, :name
end