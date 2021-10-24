# frozen_string_literal: true

module ActionExtractor
  module Extractors
    class Header < Base
      def call
        @controller.request.headers[name]
      end
    end
  end
end
