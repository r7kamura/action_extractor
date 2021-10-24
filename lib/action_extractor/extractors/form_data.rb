# frozen_string_literal: true

module ActionExtractor
  module Extractors
    class FormData < Base
      def call
        @controller.request.request_parameters[name.to_sym]
      end
    end
  end
end
