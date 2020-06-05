ENV["RAILS_ENV"] ||= "test"

require File.join(File.dirname(__FILE__), "..", "config", "environment")
require "rspec/rails"
require "factory_bot"

def sofia
  fixtures(:patient__sofia)
end

def elijah
  fixtures(:patient__elijah)
end

def joseane
  fixtures(:user__joseane)
end

def luccas
  fixtures(:user__luccas)
end

fixture_file = "#{File.dirname(__FILE__)}/support/fixture.rb"
support_files = Dir["#{File.dirname(__FILE__)}/support/**/*.rb"] - [fixture_file]
support_files.each {|f| require f }
require fixture_file

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller

  config.mock_with :rspec
  config.example_status_persistence_file_path = "tmp/rspec-persistance.txt"

  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |expectations|
   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.expect_with :rspec do |expect_config|
    expect_config.syntax = :expect
  end

  config.before(:all)  { FFaker::Random.seed=config.seed }
  config.before(:each) { FFaker::Random.reset! }

  config.before(:each) do
    I18n.locale = :en
  end

  config.after(:each) do
    AppConfig.reset_dynamic!
    # Reset gon
    RequestStore.store[:gon].gon.clear unless RequestStore.store[:gon].nil?
  end

  config.include FactoryBot::Syntax::Methods
end
