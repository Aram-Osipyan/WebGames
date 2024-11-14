module Avo
  module Fields
    class QrCodeField < Avo::Fields::BaseField
      def initialize(name, **args, &block)
        super(name, **args, &block)

        hide_on [:forms, :index]
      end
    end
  end
end
