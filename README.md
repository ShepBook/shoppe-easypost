# Easypost

## How to use this.

This Shoppe module make it easy for a customer to have and use their own EasyPost API key and give the developer a sane way to access it in production.

Just add ```gem 'shoppe-easypost'``` to your gemfile and then ```bundle install```

It provides option fields within the standard Settings tab of Shoppe.

![Screenshot of settings with EasyPost options.](/../screenshots/screenshots/menu.png?raw=true "Screenshot showing EasyPost settings in Shoppe.")

** Given the example in the above screenshot, here's the methods made available. **
These all return a string, as that's how the Shoppe settings hash system works.

```
irb > Shoppe.settings.easypost_api_key
=> "asdfasdfasdfasdfasdfasdfasdfasdfasdf"

irb > Shoppe.settings.handling_cost
=> "2.99"

irb > Shoppe.settings.from_street_1
=> "123 Average Place"

irb > Shoppe.settings.from_street_2
=> "Unit 42"

irb > Shoppe.settings.from_city
=> "Ocala"

irb > Shoppe.settings.from_state
=> "FL"

irb > Shoppe.settings.from_zipcode
=> "34471"

irb > Shoppe.settings.from_phone
=> "352-123-4567"
```