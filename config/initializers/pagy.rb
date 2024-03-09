# Better user experience handled automatically
require 'pagy/extras/navs'
require 'pagy/extras/array'
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page

# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:items] = 10 # items per page
Pagy::DEFAULT[:size]  = [1, 4, 4, 1] # nav bar links
