class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  before_action :set_locale
  before_action :gon_push_appdata

  rescue_from Sequel::NoExistingObject do
    respond_with_message(I18n.t('general.messages.not_found'), "error", 404)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(:user) || root_path
  end

  private

  def set_locale
    if user_signed_in?
      I18n.locale = current_user.language
    else
      locale = http_accept_language.language_region_compatible_from(
        I18n.available_locales.map(& :to_s ))

      locale ||= DEFAULT_LANGUAGE
      I18n.locale = locale
    end
  end

  def gon_push_appdata
    gon.push({
      locale: I18n.locale,
      user: current_user ? UserDecorator.new(current_user) : {}
    })
  end

  def respond_with_message(text, type, status, data = nil)
    @message = {:message => {:text => text, :type => type}}
    @message.merge(data) if !data.blank?

    render json: @message, :status => status
  end

  def params_filter(param)
    params[:filter].try(:[], param)
  end

  def pagination_value_for(type)
    case type
    when :page
      (params[:page] || 1).to_i
    when :per_page
      (params[:per_page] || 10).to_i
    end
  end
end
