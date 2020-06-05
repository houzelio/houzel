require 'fixture_dependencies/rspec/sequel'

FixtureDependencies.fixture_path = Rails.root.join('spec/fixtures')

RSpec::Core::ExampleGroup.class_eval do
  alias :fixtures :load
end
