# frozen_string_literal: true

module ActionExtractor
  module Extractors
    class Base
      class << self
        # @param [Symbol] argument_name
        # @param [ActionController::Base] controller
        # @param [Hash] definition
        def call(
          argument_name:,
          controller:,
          definition:
        )
          new(
            argument_name: argument_name,
            controller: controller,
            definition: definition
          ).call
        end

        # @return [Hash{Symbol => #call}]
        def extractors
          @extractors ||= {}
        end

        # @note Override.
        def inherited(child)
          super
          extractors[child.to_s.split('::').last.underscore.to_sym] = child
        end
      end

      # @param [Symbol] argument_name
      # @param [ActionController::Base] controller
      # @param [Hash] definition
      def initialize(
        argument_name:,
        controller:,
        definition:
      )
        @argument_name = argument_name
        @controller = controller
        @definition = definition
      end

      # @return [String]
      def name
        @definition[:name] || @argument_name.to_s
      end
    end
  end
end
