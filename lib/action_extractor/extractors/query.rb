# frozen_string_literal: true

module ActionExtractor
  module Extractors
    class Query < Base
      def call
        @controller.request.query_parameters[name.to_sym]
      end
    end
  end
end
