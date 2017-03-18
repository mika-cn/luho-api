
require 'minitest/autorun'
require 'luho-api'

class LuhoTest < Minitest::Test
  def test_default_hello
    assert_equal 'luho', Luho.hi
  end
end

