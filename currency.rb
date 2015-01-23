class Currency
  SYMBOLS = {'$' => :usd }
  attr_reader :amount, :code
  def initialize(*args)
    if args[0].is_a?(Float) || args[0].is_a?(Fixnum) && args[1].is_a?(Symbol)
      @amount = args[0]
      @code = args[1]
    elsif args[0].is_a?(String)
      regex = /(\W)\s*(\d+\.{0,1}\d{0,2})/
      match = args[0].match regex
      @amount = match[2].to_f
      @code = SYMBOLS[match[1]]
    end
  end

  def ==(currency)
    self.code == currency.code && self.amount == currency.amount
  end

  def +(currency)
    if self.code == currency.code
      total = self.amount + currency.amount
      code = self.code
      Currency.new(total, code)
    else
      raise DifferentCurrencyCodeError, 'DifferentCurrencyCodeError'
    end
  end
  def -(currency)
    if self.code == currency.code
      total = self.amount - currency.amount
      code = self.code
      Currency.new(total, code)
    else
      raise DifferentCurrencyCodeError, 'DifferentCurrencyCodeError'
    end
  end

  def *(number)
    if number.class == Fixnum
      total = self.amount * number
      Currency.new(total, self.code)
    elsif number.class == Float
      total = self.amount * number
      Currency.new(total, self.code)
    else
      raise 'WrongTypeOfArgument'
    end
  end
end

class DifferentCurrencyCodeError < StandardError

end
