
### A Api Client(use net/http)
support application/x-www-form-urlencoded, aplication/json, multipart/form-data

### Usage
* Define your api client class, implement host, path, method, query, body, result methods.
* perform a request use

````ruby

require 'json'


class MyApiClient
  include Luho::Api::Client
  attr_accessor :q
  def initialize(params)
    @q = params[:q]
  end

  def host
    'http://example.com'
  end

  def path
    '/search'
  end

  def method
    :get
  end

  def result
    r = Json.parse(response.body)
  end

  def query
    {:q => q}
  end
end

r = MyApiClient.request(q: 'hello')
r #=> ['hello world']

````

