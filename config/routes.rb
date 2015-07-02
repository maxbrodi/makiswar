Rails.application.routes.draw do

  # get 'fights/show'
  # get 'fights/update'
  resources 'fights'

  get 'worlds/show'
  scope '(:locale)', locale: /fr|es/ do
    root 'high_voltage/pages#show', id: 'home', as: :root_with_locale
    get '/pages/:id' => 'high_voltage/pages#show', :as => :page, :format => false
    resource :username, only: [:new, :create]
    devise_for :users
    resource :user, only: [:show, :edit, :update]
    get '/user/collection', to: 'users#collection'
    get '/user/stats', to: 'users#stats'
  end
end
