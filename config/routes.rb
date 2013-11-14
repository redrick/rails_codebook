RailsCodebook::Engine.routes.draw do

  get "/" => "codebooks#index", as: :rail_codebook_root

  # get "/get/(:lang)/:key" => "translations#get", lang: /[a-z]{2}/, key: /.*/ ,defaults: { format: "json"}
  resources :codebooks, only: [:index, :create, :destroy]

  # namespace :rails_codebook, defaults: { format: "json"} do
  #   # vseobecne, ktore budu pouzivane pri viac modeloch
  #   resources :boolean, except: [:new, :edit]
  #   resources :status, except: [:new, :edit]
  #   resources :importance, except: [:new, :edit]
  #   resources :tag, except: [:new, :edit]

  #   # model codebooky (menia normalny model na codebook)
  #   resources :users, except: [:new, :edit]
    
  #   # specificke codebooky pre jeden model
  #   resources :project_statuses, except: [:new, :edit]
  #   resources :company_relation_roles, except: [:new, :edit]
  #   resources :flow_step_statuses, except: [:new, :edit]
  #   resources :flow_step_categories, except: [:new, :edit]
  #   resources :flow_step_answers, except: [:new, :edit]
  # end

  # necessary to add into your app routes config
  # mount RailsCodebook::Engine => '/codebook_manager'

end