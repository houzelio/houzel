AVAILABLE_LANGUAGES = { "en" => 'English', "pt-BR" => 'Português (Brasil)' }
AVAILABLE_LANGUAGE_CODES = ['en', 'pt-BR']
LANGUAGE_CODES_MAP = {"pt-BR": "pt"}

DEFAULT_LANGUAGE = "en"

Houzel::Application.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
I18n.default_locale = DEFAULT_LANGUAGE


I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

AVAILABLE_LANGUAGE_CODES.each do |c|
  I18n.fallbacks[c] = [c]
  if LANGUAGE_CODES_MAP.key?(c)
    I18n.fallbacks[c].concat(LANGUAGE_CODES_MAP[c])
  end
end