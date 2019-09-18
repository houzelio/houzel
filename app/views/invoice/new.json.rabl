object false

extends "invoice/_form"

child @patients => :patients do
  attributes :id, :name
end
