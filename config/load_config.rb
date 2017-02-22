require "pathname"
require "configurate"

rails_env = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"

module Rails
  def self.root
    @__root ||= Pathname.new File.expand_path("../../", __FILE__)
  end
end

config_dir = Rails.root.join("config").to_s

AppConfig ||= Configurate::Settings.create do
  add_provider Configurate::Provider::Dynamic
  add_provider Configurate::Provider::Env

  add_provider Configurate::Provider::YAML,
               File.join(config_dir, "defaults.yml"),
               namespace: rails_env
  add_provider Configurate::Provider::YAML,
               File.join(config_dir, "defaults.yml"),
               namespace: "defaults", raise_on_missing: true

end
