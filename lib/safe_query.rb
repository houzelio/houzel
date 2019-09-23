module SafeQuery
  class Base
    def sel_column(relation, column, as = nil)
      expr = Sequel[relation][column]
      expr = expr.as(as) unless as.nil?
      expr
    end
  end

  class MergedInvoiceService < Base
    def initialize(invoice)
      @invoice = invoice
    end

    def services
      r = InvoiceService.select_all(:invoice_service)
      r = r.left_join(:service, id: :reference_id)
      r = r.where(invoice: @invoice)
      r = r.select_append(sel_column(:service, :value, :service_value))
      r
    end
  end

  class MedProfessionals < Base
    def examiners
      r = Person.select(sel_column(:person, :id), sel_column(:profile, :name))
      r = r.association_join(:profile)
      r
    end
  end
end
