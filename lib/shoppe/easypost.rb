require 'shoppe/easypost/version'
require 'shoppe/easypost/engine'

require 'shoppe/navigation_manager'

require 'EasyPost'

module Shoppe
  module Easypost
    class << self
      def api_key
        Shoppe.settings.easypost_api_key
      end

      def create_shipment(to_address, parcel)
        EasyPost.api_key = api_key
        EasyPost::Shipment.create(
          to_address: to_address,
          from_address: { company: Shoppe.settings.store_name,
                          street1: Shoppe.settings.from_street_1,
                          street2: Shoppe.settings.from_street_2,
                          city: Shoppe.settings.from_city,
                          state: Shoppe.settings.from_state,
                          zip: Shoppe.settings.from_zipcode,
                          phone: Shoppe.settings.from_phone },
          parcel: parcel)
      end

      def setup
        # Setup configuration with API key.
        # Shipping options separated by commas.
        Shoppe.add_settings_group :easypost, [:easypost_api_key,
                                              :handling_cost,
                                              :from_street_1,
                                              :from_street_2,
                                              :from_city,
                                              :from_state,
                                              :from_zipcode,
                                              :from_phone]
      end
    end
  end
end
