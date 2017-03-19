
require 'minitest/autorun'
require 'luho-api'

class ApiClientTest < Minitest::Test
  def test_test
    api = MyApi.new
    assert_nil api.response
  end

  class MyApi
    include Luho::Api::Client
  end
end
