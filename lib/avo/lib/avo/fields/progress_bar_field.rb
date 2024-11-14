module Avo
  module Fields
    class ProgressBarField < BaseField
      attr_reader :max
      attr_reader :step
      attr_reader :display_value
      attr_reader :value_suffix

      def initialize(name, **args, &block)
        super(name, **args, &block)

        @step = args[:step] || 1
        @display_value = args[:display_value] || false
        @value_suffix = args[:value_suffix] || nil
        add_prop_from_args args, name: :max, default: 100, type: :integer
      end

      def max
        return @max if @max.is_a? Numeric

        if @max.respond_to? :call
          return Avo::Hosts::RecordHost.new(block: @max, record: model).handle
        end

        []
      end
    end
  end
end
