Rails.application.routes.draw do
  mount RailsEmailPreview::Engine, at: 'emails'
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'

  get '/admin/reports/search_events', to: 'spree/admin/reports#search_events'
  # root 'static#coming_soon'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
