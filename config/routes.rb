RailsCodebook::Engine.routes.draw do

  get "/(:lang)" => "admin/codebooks#index", as: :rails_codebook_root, lang: /[a-z]{2}/

  namespace :api do
    get "/(:lang)" => "codebooks#index", as: :codebooks, lang: /[a-z]{2}/
    get "/(:lang)/:cb_name" => "codebooks#codebook_index", as: :codebook, cb_name: /[a-z]*\_*[a-z]*/, lang: /[a-z]{2}/
    get "/(:lang)/:cb_name/:id" => "codebooks#show", as: :codebook_show , cb_name: /[a-z]*\_*[a-z]*/, lang: /[a-z]{2}/    
  end

  namespace :admin do
    get       '/(:lang)'                    => 'codebooks#index', as: :codebooks
    post      '/'                           => 'codebooks#create', as: :create_codebooks
    delete    '/codebooks/:id(.:format)'    => 'codebooks#destroy', as: :codebook
  end

  # mount with
  # mount RailsCodebook::Engine => '/codebooks'

end
