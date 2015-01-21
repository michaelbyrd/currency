require 'minitest/autorun'
require 'minitest/pride'
require './currency_converter'

class CurrencyConverterTest < MiniTest::Test
  def test_currency_converter_class_exist
    assert CurrencyConverter
  end

  def test_converter_knows_its_hash
    c = CurrencyConverter.new(Hash.new)
    assert_equal Hash.new, c.rates
  end

  def test_convert_method_takes_a_currency_object_and_a_code
    c = CurrencyConverter.new(Hash.new)
    c.convert(Currency.new(1, :usd), :usd)
  end

  def test_converting_to_the_same_code_will_return_the_same_amount
    c = CurrencyConverter.new(Hash.new)
    assert_equal Currency.new(1, :usd), c.convert(Currency.new(1, :usd), :usd)
  end

  def test_convert_works_with_fixnums
    c = CurrencyConverter.new({usd: 1, can: 2})
    result = c.convert(Currency.new(1, :usd), :can)
    assert_equal Currency.new(2, :can), result
  end

  def test_convert_works_with_float_rates
    c = CurrencyConverter.new({usd: 1, can: 1.5})
    result = c.convert(Currency.new(1, :usd), :can)
    assert_equal Currency.new(1.5, :can), result
  end

  def test_convert_method_takes_a_string_and_a_code
    c = CurrencyConverter.new(Hash.new)
    c.convert("$12.00", :usd)
  end

  def test_convert_method_will_not_take_improper_args
    c = CurrencyConverter.new(Hash.new)
    assert_raises(TypeError) {c.convert([],:usd)}
  end


end
