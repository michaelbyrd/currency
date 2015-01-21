class Currency
  attr_reader :amount, :code
  def initialize(amount, code)
    @amount = amount
    @code = code
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
