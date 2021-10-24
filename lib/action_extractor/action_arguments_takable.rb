# frozen_string_literal: true

module ActionExtractor
  module ActionArgumentsTakable
    # @note Override.
    def send_action(method_name, *arguments)
      extraction = self.class.extractions[method_name]
      if extraction
        keyword_arguments = extraction.definitions.each_with_object({}) do |(argument_name, definition), object|
          name = definition[:name] || argument_name.to_s
          from = definition[:from]
          object[argument_name] = begin
            case from
            when :header
              request.headers[name]
            when :form_data
              request.request_parameters[name.to_sym]
            when :path
              request.path_parameters[name.to_sym]
            else
              raise ::ArgumentError, "Unknown :from value in `.extract` arguments: `#{from}`."
            end
          end
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
