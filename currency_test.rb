require 'minitest/autorun'
require 'minitest/pride'
require './currency'

class CurrencyTest < MiniTest::Test
  def test_currency_class_exist
    assert Currency
  end

  def test_currency_knows_its_amount_and_code
    a = Currency.new(10, :usd)
    assert_equal 10, a.amount
    assert_equal :usd, a.code
  end

  def test_currency_can_be_equivalent
    a = Currency.new(10, :usd)
    b = Currency.new(10, :usd)
    c = Currency.new(10, :jpy)
    assert a == b
    refute a == c
  end

  def test_that_currency_with_the_same_code_can_be_added
    a = Currency.new(5, :usd)
    b = Currency.new(5, :usd)
    result = a + b
    assert_equal 10, result.amount
    refute 11 == result.amount
    assert_equal :usd, result.code
  end

  def test_that_currency_with_different_codes_can_not_be_added
    a = Currency.new(5, :usd)
    b = Currency.new(5, :jpy)
    assert_raises(DifferentCurrencyCodeError) { a + b }
    assert_raises(DifferentCurrencyCodeError) { a - b }

  end

  def test_that_currency_with_the_same_code_can_be_subtracted
    a = Currency.new(5, :usd)
    b = Currency.new(2, :usd)
    result = a - b
    assert_equal 3, result.amount
    assert_equal :usd, result.code
  end

  def test_that_currency_with_different_codes_can_not_be_subtracted
    a = Currency.new(5, :usd)
    b = Currency.new(3, :jpy)
    begin
    a - b
    rescue Exception => ex
      assert_equal 'DifferentCurrencyCodeError', ex.message
    end
  end

  def test_that_currency_can_be_multiplied_by_a_fixnum
    a = Currency.new(10, :usd)
    result = a*10
    assert_equal 100, result.amount
  end

  def test_that_currency_can_be_multiplied_by_a_float
    a = Currency.new(10, :usd)
    result = a*1.5
    assert_equal 15.0, result.amount
    assert_equal Float, result.amount.class
  end

  def test_that_current_can_not_be_multiplied_by_other_objects
    a = Currency.new(10, :usd)
    begin
      a*'string'
    rescue Exception => ex
      assert_equal 'WrongTypeOfArgument', ex.message
    end
  end

  def test_that_currency_can_be_initialize_with_a_string
    c = Currency.new("$10.00")
    d = Currency.new("$10")
    assert_equal 10.00, c.amount
    assert_equal 10, d.amount
  end

end
