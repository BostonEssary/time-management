# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-autocomplete" # @3.1.0
pin "swiper/element/bundle", to: "https://cdn.jsdelivr.net/npm/swiper@11.2.1/swiper-element-bundle.min.js"
pin "@stimulus-components/carousel", to: "@stimulus-components--carousel.js" # @6.0.0
pin "swiper/bundle", to: "swiper--bundle.js" # @11.2.2
pin "@stimulus-components/popover", to: "@stimulus-components--popover.js" # @7.0.0
