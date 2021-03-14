Rails.application.routes.draw do
  get 'informations_imports/new'
  get 'informations_imports/create'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :informations_imports, only: [:new, :create]

  root to: 'users#index'
end
