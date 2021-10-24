# frozen_string_literal: true

module ActionExtractor
  module Extractors
    class Path < Base
      def call
        @controller.request.path_parameters[name.to_sym]
      end
    end
  end
end
