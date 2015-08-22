Rails.application.routes.draw do

  get 'tutoworlds/show'

  get 'recaps/show'
  patch 'recaps/update'

  get 'fights/show'
  post 'fights/show'
  get 'fights/update'
  patch 'fights/update'

  get 'worlds/show'
  put 'worlds/update', to: 'worlds#update'
  scope '(:locale)', locale: /fr|es/ do
    root 'high_voltage/pages#show', id: 'home', as: :root_with_locale
    get '/pages/:id' => 'high_voltage/pages#show', :as => :page, :format => false
    resource :username, only: [:new, :create]
    devise_for :users
    resource :user, only: [:show, :update]
    get '/user/collection', to: 'users#collection'
    get '/user/stats', to: 'users#stats'
  end

  resources :items

end
