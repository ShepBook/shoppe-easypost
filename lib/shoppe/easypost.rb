require "shoppe/easypost/version"
require "shoppe/easypost/engine"

require 'shoppe/navigation_manager'

require "EasyPost"

module Shoppe
  module Easypost

    # Add easypost shipping tab to shoppe
    # Shoppe::NavigationManager.build(:admin_primary) do
    #   add_item :orders
    #   add_item :products
    #   add_item :product_categories
    #   add_item :delivery_services
    #   add_item :tax_rates
    #   add_item :users
    #   add_item :countries
    #   add_item :settings
    #   add_item :easypost
    # end

    class << self

      def api_key
        Shoppe.settings.easypost_api_key
      end

      def create_shipment(to_address, parcel)
        EasyPost.api_key = self.api_key

        EasyPost::Shipment.create(
          {
            to_address: to_address,
            from_address: {company: Shoppe.settings.store_name,
                           street1: Shoppe.settings.from_street_1,
                           street2: Shoppe.settings.from_street_2,
                           city: Shoppe.settings.from_city,
                           state: Shoppe.settings.from_state,
                           zip: Shoppe.settings.from_zipcode,
                           phone: Shoppe.settings.from_phone},
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

      def easypost_delivery_service_prices(shipment)
        if delivery_required?
        end
      end

      def setup
        # Setup configuration with API key. Shipping options separated by commas.
        Shoppe.add_settings_group :easypost, [:easypost_api_key, :handling_cost, :from_street_1, :from_street_2, :from_city, :from_state, :from_zipcode, :from_phone]

        Shoppe::Order.before_confirmation do

        end
      end
    end
  end
end