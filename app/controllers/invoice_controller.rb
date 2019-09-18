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

  def invoice_params
    params.require(:invoice).permit(:patient_id, :bill_date, :remarks)
  end

  def invoice_fields
    [:patient_id, :bill_date, :remarks]
  end
end
