
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
  #s.executables << 'luho'
  s.files = [
    "lib/luho.rb",
    "lib/luho/translator.rb",
    "bin/luho"
  ]
  s.test_files = [
    "test/test_luho.rb"
  ]
end
