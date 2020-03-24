require('pry-byebug')
require_relative('./models/properties')

property1 = Property.new({'address' => '122 Waterloo Road',
                         'value' => 210_000,
                         'no_of_bedrooms' => 4,
                         'year_built' => 2007
                         })

property2 = Property.new({'address' => '56 Bath Street',
                          'value' => 195_000,
                          'no_of_bedrooms' => 2,
                          'year_built' => 2001
                         })

property1.address = "7 Glasgow Road"
property1.value = 225_000
property1.save()
property1.delete()

binding.pry
nil
