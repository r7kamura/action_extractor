# frozen_string_literal: true

module ActionExtractor
  module ControllerDsl
    def extract(**definitions)
      Extraction.new(
        controller_class: self,
        definitions: definitions
      )
    end

    # @return [Hash]
    def extractions
      @extractions ||= {}
    end
  end
end
