module Avo
  module Fields
    class TextField < BaseField
      attr_reader :link_to_resource
      attr_reader :as_html
      attr_reader :protocol
      attr_reader :copy_to_clipboard

      def initialize(id, **args, &block)
        super(id, **args, &block)

        add_boolean_prop args, :link_to_resource
        add_boolean_prop args, :as_html
        add_boolean_prop args, :copy_to_clipboard
        add_string_prop args, :protocol
      end
    end
  end
end
