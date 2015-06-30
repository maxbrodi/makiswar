Rails.application.routes.draw do
  get 'worlds/show'

  devise_for :users
end
