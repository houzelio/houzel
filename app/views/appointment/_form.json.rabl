child @patients => :patients do
  attributes :id, :name
end

child @examiners => :examiners do
  node do |att| {
    :id => att[:id],
    :name => att[:name]
   }
  end
end
