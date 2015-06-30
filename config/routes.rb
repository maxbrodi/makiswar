Rails.application.routes.draw do

  get 'worlds/show'

  scope '(:locale)', locale: /fr|es/ do
    root 'high_voltage/pages#show', id: 'home', as: :root_with_locale
    get "/pages/:id" => "high_voltage/pages#show", :as => :page, :format => false
    devise_for :users
    resource :username, only: [:new, :create]
  end

end
