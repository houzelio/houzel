object false

child @users => :items do
  node do |att| {
    :id => att[:id],
    :name => att[:name],
    :role_name => att[:role_name]
    }
  end
end
