require "shoppe/easypost/version"
require "shoppe/easypost/engine"

module Shoppe
  module Easypost

    class << self

      def api_key
        Shoppe.settings.easypost_api_key
      end

      def setup
        # Setup configuration with API key. Shipping options separated by commas.
        Shoppe.add_settings_group :easypost, [:easypost_api_key, :easypost_shipping_options]

        require "EasyPost"
      end

  end
end