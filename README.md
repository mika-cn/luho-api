
### A Api Client
support application/x-www-form-urlencoded, aplication/json, multipart/form-data

### Get Start
* Define your api client class, include `Luho::Api::Client` and implement host, path, method, query, body, result methods.
* send a request

````ruby
#host   : root url without '/' (eg: http://example.com)
#path   : request path   (eg: '/search')
#method : request method (eg: 'post')
#query  : query hash     (eg: {q: 'hello'})
#body   : post data hash (use in post request)
#result : deal with response (will call when request finish)
````

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

### request headers
`Luho::Api::Client` serialize your post data according to header `'Content-Type'` which default is `'application/json'`.

overwrite `#_get_headers` or `#_post_headers` to provider a hash of headers

#### example:
````ruby
def method
  :post
end

def _post_headers
  {
     'Content-Type' => 'application/x-www-form-urlencoded',
     'My-Header' => 'Hello'
  }
end
````
