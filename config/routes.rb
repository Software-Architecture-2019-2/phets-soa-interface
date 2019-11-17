Rails.application.routes.draw do
  get 'soapconsumer/respuesta'

  get 'soapconsumer', to: 'soapconsumer#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  wash_out :wsevents

end
