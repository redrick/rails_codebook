RailsCodebook::Engine.routes.draw do

  get "/(:lang)" => "admin/codebooks#index", as: :rail_codebook_root, lang: /[a-z]{2}/

  namespace :api do
    get "/(:lang)" => "codebooks#index", as: :rail_codebook_root, lang: /[a-z]{2}/
    # resources :codebooks, only: [:index, :create, :destroy]
    get "/(:lang)/:cb_name" => "codebooks#codebook_index", cb_name: /[a-z]+/, lang: /[a-z]{2}/
    get "/(:lang)/:cb_name/:id" => "codebooks#show", cb_name: /[a-z]+/, lang: /[a-z]{2}/    
  end

  namespace :admin do
    resources :codebooks  
    # admin_codebooks_path        GET     /admin/codebooks(.:format)            rails_codebook/admin/codebooks#index
    #                             POST    /admin/codebooks(.:format)            rails_codebook/admin/codebooks#create  
    # new_admin_codebook_path     GET     /admin/codebooks/new(.:format)        rails_codebook/admin/codebooks#new
    # edit_admin_codebook_path    GET     /admin/codebooks/:id/edit(.:format)   rails_codebook/admin/codebooks#edit
    # admin_codebook_path         GET     /admin/codebooks/:id(.:format)        rails_codebook/admin/codebooks#show
    #                             PATCH   /admin/codebooks/:id(.:format)        rails_codebook/admin/codebooks#update
    #                             PUT     /admin/codebooks/:id(.:format)        rails_codebook/admin/codebooks#update
    #                             DELETE  /admin/codebooks/:id(.:format)        rails_codebook/admin/codebooks#destroy
  end

end
