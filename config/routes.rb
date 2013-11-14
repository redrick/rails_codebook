RailsCodebook::Engine.routes.draw do

  namespace :api do
    get "/(:lang)" => "codebooks#index", as: :rail_codebook_root, lang: /[a-z]{2}/
    resources :codebooks, only: [:index, :create, :destroy]
    get "/(:lang)/:cb_name" => "codebooks#codebook_index", cb_name: /[a-z]+/, lang: /[a-z]{2}/
    get "/(:lang)/:cb_name/:id" => "codebooks#show", cb_name: /[a-z]+/, lang: /[a-z]{2}/    
  end

end
