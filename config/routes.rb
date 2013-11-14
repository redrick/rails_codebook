RailsCodebook::Engine.routes.draw do

  get "/" => "translations#index", as: :redis_dictionary_root
  get "/get/(:lang)/:key" => "translations#get", lang: /[a-z]{2}/, key: /.*/ ,defaults: { format: "json"}
  resources :translations, only: [:index, :create, :destroy]

  # necessary to add into your app routes config
  # mount RailsCodebook::Engine => '/codebook_manager'

end