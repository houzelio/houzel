module Houzel::Money

  def self.simple_value(value)
    if value.present?
      value = (value.is_a? Numeric) ? "%.2f" % value : value

      m = Money.new(value.gsub(/\D+/, ""))
      m.format(symbol: nil, thousands_separator: "", decimal_mark: ".")
    end
  end
end
