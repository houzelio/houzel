class ServiceController < ApplicationController
  include ActionView::Helpers::NumberHelper
  respond_to :json

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i

    services = Service.order(Sequel.desc(:category), :name).paginate(page, per_page)
    if params_filter(:name)
      services = services.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    @services = services
  end

  def create
    service = Service.new
    service.set_fields(service_params, service_fields)

    if service.save
      respond_with_message(I18n.t('service.messages.saved'), "success", :ok)
    else
      respond_with service
    end
  end

  def show
    @service = Service.first(id: params[:id])
    raise Sequel::NoExistingObject unless @service.present?
  end

  private

  def service_params
    params.require(:service).permit(:name, :category).tap do |p|
      m = Money.new(params[:value].to_s.gsub(/\D+/, ""))
      p[:value] = m.format(symbol: nil, thousands_separator: "", decimal_mark: ".")
    end
  end

  def service_fields
    [:name, :category, :value]
  end
end
