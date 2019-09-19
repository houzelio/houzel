class InvoiceDecorator < ApplicationDecorator
  delegate_all

  def bill_date
    I18n.l(invoice.bill_date, format: :date) if invoice.bill_date
  end
end
