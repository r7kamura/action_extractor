# frozen_string_literal: true

require_relative 'action_extractor/version'

module ActionExtractor
  autoload :ActionArgumentsTakable, 'action_extractor/action_arguments_takable'
  autoload :ControllerDsl, 'action_extractor/controller_dsl'
  autoload :Extraction, 'action_extractor/extraction'
end

AbstractController::Base.prepend ActionExtractor::ActionArgumentsTakable
