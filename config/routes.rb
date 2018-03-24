Rails.application.routes.draw do
  get 'static_pages/index'

  root      'static_pages#index'
  resources :users, only: [:show,:create]
  resources :messages, only: [:create]
  resources :rooms, only: [:index,:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
