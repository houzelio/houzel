class InvoiceController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    page = pagination_value_for(:page)
    per_page = pagination_value_for(:per_page)

    invoices = Invoice.select_all(:invoice).select_append(:name).association_join(:patient)
    if params_filter(:name)
      invoices = invoices.where(Sequel.ilike(:name, "%#{params_filter(:name)}%"))
    end

    invoices = invoices.order(Sequel.desc(:updated_at), :name).paginate(page, per_page)
    @invoices = InvoiceDecorator.decorate_collection(invoices)
  end

  def new
    @patients = Patient.select(:id, :name).where(deleted_at: nil).order(:name)
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
    invoice = Invoice[params[:id]]
    raise Sequel::NoExistingObject unless invoice.present?

    @invoice = InvoiceDecorator.new(invoice)

    @services = services_select
    @invoice_services = SafeQuery::MergedInvoiceService.new(invoice).services
  end

  def update
    invoice = Invoice[params[:id]]
    raise Sequel::NoExistingObject unless invoice.present?
    invoice.add_invoice_services(params[:invoice_services])

    if invoice.update_fields(invoice_params, invoice_fields)
      respond_with_message(I18n.t('invoice.messages.updated'), "success", :ok)
    else
      respond_with invoice
    end
  end

  def destroy
    invoice = Invoice[params[:id]]
    raise Sequel::NoExistingObject unless invoice.present?

    if invoice.destroy()
      respond_with_message(I18n.t('invoice.messages.deleted'), "success", :ok)
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
