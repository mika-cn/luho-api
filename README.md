
### A Api Client(use net/http)
support application/x-www-form-urlencoded, aplication/json, multipart/form-data

### Get Start
* Define your api client class, implement host, path, method, query, body, result methods.
* send a request

#### example:
````ruby

# base_client.rb
require 'json'
class BaseClient
  include Luho::Api::Client
  def host
    'http://example.com'
  end

  def result
    Json.parse(response.body)
  end
end

# my_client.rb
class MyClient < BaseClient
  attr_accessor :q
  def initialize(params)
    @q = params[:q]
  end

  def path
    '/search'
  end

  def method
    :get
  end

  def query
    {:q => q}
  end

end

r = MyClient.request(q: 'hello')
r #=> ['hello world']

````

