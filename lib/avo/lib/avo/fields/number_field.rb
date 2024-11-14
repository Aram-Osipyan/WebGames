module Avo
  module Fields
    class NumberField < TextField
      attr_reader :min
      attr_reader :max
      attr_reader :step

      def initialize(id, **args, &block)
        super(id, **args, &block)

        @min = args[:min].present? ? args[:min].to_f : nil
        @step = args[:step].present? ? args[:step].to_f : nil
        add_prop_from_args args, name: :max, default: nil, type: :float
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
