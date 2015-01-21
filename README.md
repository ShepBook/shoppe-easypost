# shoppe-easypost

## How to use this.

This Shoppe module make it easy for a customer to have and use their own EasyPost API key and give the developer a sane way to access it in production.

Just add ```gem 'shoppe-easypost'``` to your gemfile and then ```bundle install```

It provides option fields within the standard Settings tab of Shoppe.

![Screenshot of settings with EasyPost options.](/../screenshots/screenshots/menu.png?raw=true "Screenshot showing EasyPost settings in Shoppe.")

**Given the example in the above screenshot, here's the methods made available.**

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

**Using the data from the above Shoppe settings that are returned, you can call some handy methods I've built into this Gem.**

```Shoppe::Easypost::create_shipment``` can be used to create a shipment with a single call, as seen in the EasyPost getting started docs. Here's the code:

```
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
```

You'll need to provide a ```to_address``` and a ```parcel``` as arguments into the ```create_shipment``` method. Using the example from EasyPost's Getting Started page, a call to this method would look like this:

```
buyer_address = {
      name: 'George Costanza',
      company: 'Vandelay Industries',
      street1: '1 E 161st St.',
      city: 'Bronx',
      state: 'NY',
      zip: '10451'
    }

parcel = {
      length: 9,
      width: 6,
      height: 2,
      weight: 10
    }

shipment = Shoppe::Easypost::create_shipment(buyer_address, parcel)
```

You can then use that ```shipment``` object to get rates and such, as in the EasyPost Docs.

**I hope you find this gem to be useful. It is currently following the convention of Shoppe in that in provides access to data, but does not dictate how you utilize this data.**

I'm considering options to make this a bit more opinionated, with options to override the default shipping system in Shoppe. Currently, I'd suggest making a generic Shipping item in Shoppe, then use the data you get back from EasyPost to override things like the price of the shipping object in Shoppe. You should be able to inject this into the checkout workflow before they get to payment, so you can show an accurate price. I've done this for a client project, however, I'm not permitted to divulge that code.

If you have questions specific to your project, how to implement it in your project, and you'd like me to take a look and make some suggestions, feel free to drop me a line at jared@apogeezenith.com or ping me on twitter @shepbook. I've worked with Shoppe and EasyPost pretty extensively over the last year and would be happy to help.