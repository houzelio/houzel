class InvoiceController < ApplicationController
  respond_to :json

  def new
    @patients = Patient.select(:id, :name).order(:name)
    @services = services_select
  end

  def create
    invoice = Invoice.new
    invoice.set_fields(invoice_params, invoice_fields)
    invoice.add_invoice_services(params[:invoice_services])

    if invoice.save()
      respond_with_message(I18n.t('invoice.messages.saved'), "success", :ok)
    else
      respond_with invoice
    end
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
