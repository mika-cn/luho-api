require 'luho/api/util'
require 'luho/api/error'
module Luho
  module Api
    module Client
      def self.included(mod)
        mod.class_eval do
          attr_reader :response
        end
      end

      def self.request(params)
        api = new params
        api._request
      end

      private

      def _request
        begin
          @response = \
          case method.to_s.downcase
          when 'get'  then _get
          when 'post' then _post
          end
          result
        rescue => e
          msg = <<-HINT
            url:   #{host + path}
            method: #{method}
            header: #{_post_headers}
            query: #{query}
            body:  #{body}
            message: #{e.message}
          HINT
          raise Luho::Api::Error.new(self, msg)
        end
      end

      def _get
        Luho::Api::Util.get({
          path: host + path,
          query: query,
          headers: _get_headers
        }, &sign_request)
      end

      def _post
        Luho::Api::Util.post({
          path: host + path,
          query: query,
          headers: _post_headers,
          body: body
        }, &sign_request)
      end

      def _get_headers
        {'Content-Type' => 'application/json'}
      end

      def _post_headers
        {'Content-Type' => 'application/json'}
      end

      def method
        raise Luho::Api::Error.new(self, 'Implement Me')
      end

      def host
        raise Luho::Api::Error.new(self, 'Implement Me')
      end

      def path
        raise Luho::Api::Error.new(self, 'Implement Me')
      end

      def result
        raise Luho::Api::Error.new(self, 'Implement Me')
      end

      def query
        {}
      end

      def body
        {}
      end

      def sign_request
        Proc.new {|request| request }
      end

    end
  end
end
