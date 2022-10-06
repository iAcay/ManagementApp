Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :projects
  resources :accounts, only: %i[new create]
  get 'new_user_to_account', to: 'accounts#new_user_to_account'
  post 'add_user_to_account', to: 'accounts#add_user_to_account'
end
