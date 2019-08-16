class ServiceController < ApplicationController
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
end
