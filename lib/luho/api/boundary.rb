module Luho
  module Api
    class Boundary
      require 'securerandom'
      def self.create
        s = SecureRandom.base64(12)
        '----RubyFormBoundary' + s.tr('+/', 'AB')
      end
    end
  end
end
