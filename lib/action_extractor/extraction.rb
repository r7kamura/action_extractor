# frozen_string_literal: true

module ActionExtractor
  class Extraction
    # @return [Hash]
    attr_reader :definitions

    # @param [Class] controller_class
    # @param [Hash] definitions
    def initialize(
      controller_class:,
      definitions:
    )
      @controller_class = controller_class
      @definitions = definitions
    end

    # @param [Symbol] action_name
    # @return [Symbol]
    def on(action_name)
      @controller_class.extractions[action_name.to_s] = self
      action_name
    end
  end
end
