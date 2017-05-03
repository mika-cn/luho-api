require 'net/http'
require 'openssl'
require 'luho/api/boundary'
require 'luho/api/multipart'
module Luho
  module Util
    # return a Net::HTTPResponse object
    def self.get(path:, query: {}, headers: {})
       uri = get_uri(path, query)
       req = Net::HTTP::Get.new(uri.request_uri, headers)
       req = (yield req) if block_given?
      http = get_http(uri)
      http.request(req)
    end

    # body: params
    # return a Net::HTTPResponse object
    def self.post(path:, query: {}, body:, headers: {})
       uri = get_uri(path, query)
       req = Net::HTTP::Post.new(uri.request_uri, headers)
       case req.content_type
       when 'application/x-www-form-urlencoded'
         req.body = URI.encode_www_form(body)
       when 'application/json'
         req.body = (body.is_a?(String) ? body : body.to_json)
       when 'multipart/form-data'
         boundary = Boundary.create
         req.content_type = "#{req.content_type}; boundary=#{boundary}"
         req.body = Multipart.new(params: body, boundary: boundary).to_req_body
       end
       req = (yield req) if block_given?
      http = get_http(uri)
      http.request(req)
    end

    def self.get_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if 'https' == uri.scheme
        http.verify_mode =  OpenSSL::SSL::VERIFY_NONE
        http.use_ssl = true
      end
      http.open_timeout = 10
      http.read_timeout = 10
      http
    end

    def self.get_uri(path, query)
      uri = URI(path)
      uri.query = URI.encode_www_form(query) if !query.empty?
      uri
    end

  end
end
