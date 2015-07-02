Rails.application.routes.draw do

  get 'fights/show'
  get 'worlds/show'
  put 'worlds/update', to: 'worlds#update'
  scope '(:locale)', locale: /fr|es/ do
    root 'high_voltage/pages#show', id: 'home', as: :root_with_locale
    get '/pages/:id' => 'high_voltage/pages#show', :as => :page, :format => false
    resource :username, only: [:new, :create]
    devise_for :users
    resource :user, only: [:show]
    get '/user/collection', to: 'users#collection'
    get '/user/stats', to: 'users#stats'
  end
end
