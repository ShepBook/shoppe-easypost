module Shoppe
  module Easypost
    class Engine < Rails::Engine
      initializer 'shoppe.easypost.initializer' do
        Shoppe::Easypost.setup
      end
    end
  end
end
