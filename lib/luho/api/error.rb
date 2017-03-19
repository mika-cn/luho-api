module Luho
  module Api
    class Error < StandardError
      def initialize(context, msg)
        klass_name = (Class == context.class ? context.name : context.class.name)
        super "in class: #{klass_name}\n#{msg}"
      end
    end
  end
end
