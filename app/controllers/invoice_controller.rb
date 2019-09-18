class InvoiceController < ApplicationController
  respond_to :json

  def new
    @patients = Patient.select(:id, :name).order(:name)
    @services = services_select
  end

  private

  def services_select
    Service.order(:name)
  end
end
