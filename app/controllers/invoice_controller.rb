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

  def show
    invoice = Invoice.first(id: params[:id])
    raise Sequel::NoExistingObject unless invoice.present?

    @invoice = InvoiceDecorator.new(invoice)

    @services = services_select
    @invoice_services = SafeQuery::MergedInvoiceService.new(invoice).services
  end

  def update
    invoice = Invoice.first(id: params[:id])
    raise Sequel::NoExistingObject unless invoice.present?
    invoice.add_invoice_services(params[:invoice_services])

    if invoice.update_fields(invoice_params, invoice_fields)
      respond_with_message(I18n.t('invoice.messages.updated'), "success", :ok)
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
