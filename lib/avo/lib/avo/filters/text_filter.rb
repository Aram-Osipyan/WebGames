module Avo
  module Filters
    class TextFilter < BaseFilter
      class_attribute :button_label
      class_attribute :datetime_picker, default: false

      self.template = "avo/base/text_filter"

      def selected_value(applied_filters)
        applied_or_default_value
      end
    end
  end
end
