module Luho
  module Api
    class Multipart
      require 'tempfile'
      EOL = "\r\n"
      attr_accessor :params, :boundary
      def initialize(params:, boundary:)
        @params = params
        @boundary = boundary
      end

      def to_req_body
        b = '--' + boundary
        @stream = Tempfile.new("HttpUtil.Stream.#{rand(1000)}")
        @stream.binmode
        @stream.write(b + EOL)
        last_index = params.length - 1
        params.each_with_index do |kv, idx|
          k,v = *kv
          if v.respond_to?(:read) && v.respond_to?(:path)
            create_file_field(@stream, k, v)
          else
            create_regular_field(@stream, k, v)
          end
          @stream.write(EOL + b)
          @stream.write(EOL) if last_index != idx
        end
        @stream.write('--')
        @stream.write(EOL)
        @stream.seek(0)
        c = @stream.read
        @stream.seek(0)
        c
      end

      def create_regular_field(s, k, v)
        s.write("Content-Disposition: form-data; name=\"#{k}\"")
        s.write(EOL)
        s.write(EOL)
        s.write(v)
      end

      def create_file_field(s, k, v)
        begin
          s.write("Content-Disposition: form-data;")
          s.write(" name=\"#{k}\";") unless (k.nil? || k=='')
          s.write(" filename=\"#{v.respond_to?(:original_filename) ? v.original_filename : File.basename(v.path)}\"#{EOL}")
          s.write("Content-Type: #{v.respond_to?(:content_type) ? v.content_type : 'image/jpeg'}#{EOL}")
          s.write(EOL)
          while (data = v.read(8124))
            s.write(data)
          end
        ensure
          v.close if v.respond_to?(:close)
        end
      end
    end

  end
end
