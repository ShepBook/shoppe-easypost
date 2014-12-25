require "shoppe/easypost/version"
require "shoppe/easypost/engine"

require "EasyPost"

module Shoppe
  module Easypost

    class << self

      def api_key
        Shoppe.settings.easypost_api_key
      end

      def create_shipment(to_address, from_address, parcel)
        EasyPost.api_key = self.api_key

        EasyPost::Shipment.create(
          {
            to_address: to_address,
            from_address: from_address,
            parcel: parcel
          }
        )
      end

      def allowed_shipping_options
        option_codes = []
        Shoppe::DeliveryService.all.each do |ds|
          option_codes << ds.code
        end

        option_codes
      end

      def available_options_and_rates(shipment)
        available_rates = []
        shipment.rates.each do |rate|
          if self.allowed_shipping_options.include? rate.service
            available_rates << rate
          end
        end

        available_rates
      end

      def shipping_and_handling_costs(rates)
        rates.each do |rate|
          puts rate.rate.to_f + Shoppe.settings.handling_cost.to_f
        end
      end

      def setup
        # Setup configuration with API key. Shipping options separated by commas.
        Shoppe.add_settings_group :easypost, [:easypost_api_key, :handling_cost]
      end
    end
  end
end