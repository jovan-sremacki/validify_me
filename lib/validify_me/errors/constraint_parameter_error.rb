# frozen_string_literal: true

module ValidifyMe
  module Errors
    # This error is raised when a parameter does not meet expected constraints
    class ConstraintParameterError < StandardError
      attr_reader :param_name

      def initialize(param_name)
        @param_name = param_name
        super("Parameter '#{param_name}' does not meet specified constraints.")
      end
    end
  end
end
