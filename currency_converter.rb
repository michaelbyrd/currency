require './currency'

class CurrencyConverter
  SYMBOLS = {"$" => :usd }
  attr_reader :rates
  def initialize(hash)
    @rates = hash
  end

  def convert(currency, code)
    if currency.class == Currency
      if currency.code == code
        currency
      else
        total = currency.amount / rates[currency.code] * rates[code]
        Currency.new(total, code)
      end
    elsif currency.class == String
      new_currency = Currency.new(currency[1..-1].to_f, SYMBOLS[currency[0]])
      convert(new_currency, code)
    else
      raise TypeError, "CurrencyConverter.convert(curreny, code) where currency is a currency object or a string like '$12.00'"
    end
  end

end
