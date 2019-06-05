class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  before_action :set_locale
  before_action :gon_push_appdata

  private

  def set_locale
    locale = http_accept_language
              .language_region_compatible_from I18n.available_locales.map(& :to_s )

    locale ||= DEFAULT_LANGUAGE
    I18n.locale = locale
  end

  def gon_push_appdata
    gon.push(locale: I18n.locale)
  end

end
