class Invoice < Sequel::Model
  plugin :timestamps, force: true, update_on_create: true
  plugin :instance_hooks
  plugin :delay_add_association

  many_to_one :patient
  one_to_many :invoice_service

  def add_invoice_services(items_hash)
    invoice_services = Array.new
    pks = Array.new

    format_value = -> (value) {
      value = (value.is_a? Numeric) ? "%.2f" % value : value

      m = Money.new(value.gsub(/\D+/, ""))
      m.format(symbol: nil, thousands_separator: "", decimal_mark: ".")
    }

    items_hash.each { |p|
      p[:value] = format_value.call(p[:value])

      if new?
        is = InvoiceService.new(p.permit(:name, :value, :reference_id))
        add_invoice_service(is)
      else
        id = p[:id] !~ /srvc/ ? p[:id] : nil

        if (is = InvoiceService[id]).present?
          is.set_fields(p.permit(:value), [:value])
          pks.push(is.pk)
        else
          is = InvoiceService.new(p.permit(:name, :value, :reference_id).merge(invoice: self))
        end

        invoice_services.push(is) if is.modified?
      end
    }

    excl_expr = InvoiceService.exclude(id: pks).where(invoice: self)
    destroy = excl_expr.select(1).group(:invoice_id).first

    if invoice_services.present? || destroy
      modified!

      after_save_hook{
        excl_expr.destroy

        invoice_services.each { |is|
          is.save_changes()
        }
      }
    end
  end
end
