
Gem::Specification.new do |s|
  s.name        = 'luho-api'
  s.version     = '0.0.1'
  s.summary     = 'A Api Client(use net/http), support application/x-www-form-urlencoded, aplication/json, multipart/form-data'
  s.description = <<-EOF
    A Simple luho-api gem
  EOF
  s.date        = '2017-03-18'
  s.author      = 'mika'
  s.email       = 'laoquans@gmail.com'
  s.homepage    = 'https://github.com/mika-cn/luho-api'
  s.license     = 'MIT'
  s.files = [
    'lib/luho-api.rb',
    'lib/luho/api.rb',
    'lib/luho/api/client',
    'lib/luho/api/error',
    'lib/luho/api/util',
    'lib/luho/api/boundary.rb',
    'lib/luho/api/multipart.rb'
  ]
  s.test_files = [
    'test/test_api_client.rb'
  ]
end
