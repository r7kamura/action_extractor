# frozen_string_literal: true

module ActionExtractor
  module ActionArgumentsTakable
    # @note Override.
    def send_action(method_name, *arguments)
      extraction = self.class.extractions[method_name]
      if extraction
        keyword_arguments = extraction.definitions.each_with_object({}) do |(argument_name, definition), object|
          extractor = Extractors::Base.extractors[definition[:from]]
          unless extractor
            raise ::ArgumentError, "Unknown :from value in `.extract` arguments: `#{definition[:from].inspect}`."
          end

          object[argument_name] = extractor.call(
            argument_name: argument_name,
            controller: self,
            definition: definition
          )
        end
        super(
          method_name,
          *arguments,
          **keyword_arguments,
        )
      else
        super
      end
    end
  end
end
