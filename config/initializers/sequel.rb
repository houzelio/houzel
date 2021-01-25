require "sequel_rails/railties/legacy_model_config"

Sequel::Model.class_eval do
  private

  def default_validation_helpers_options(type)
    case type
    when :presence
      {message: lambda{I18n.t("sequel.messages.presence")}}
    when :max_length
      {message: lambda{|max| I18n.t("sequel.messages.max_length", :set => max)}}
    when :min_length
      {message: lambda{|min| I18n.t("sequel.messages.min_length", :set => min)}}
    when :includes
      {message: lambda{|set| I18n.t("sequel.messages.includes", :set => set.inspect)}}
    when :format
      {message: lambda{|with| I18n.t("sequel.messages.format", :with => with)}}
    when :not_null
      {message: lambda{I18n.t("sequel.messages.not_null")}}
    when :unique
      {message: lambda{I18n.t("sequel.messages.unique")}}
    when :numeric
      {message: lambda{I18n.t("sequel.messages.numeric")}}
    when :integer
      {message: lambda{I18n.t("sequel.messages.integer")}}
    else
      super
    end
  end
end
