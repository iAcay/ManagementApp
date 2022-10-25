Rails.application.routes.draw do
  # resources :user_projects
  resources :artifacts
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :projects, except: %i[index] do
    collection do
      resources :user_projects, only: %i[create destroy]
    end
  end
  resources :accounts, except: %i[index show]
  resources :invitations, only: %i[index]
  get 'new_user_to_account', to: 'accounts#new_user_to_account'
  post 'invite_user_to_account', to: 'accounts#invite_user_to_account'
  delete 'cancel_invitation', to: 'accounts#cancel_invitation'
  post 'recognize_invitation', to: 'accounts#recognize_invitation'
  post 'buy_premium_plan', to: 'checkout#buy_premium_plan'
  post 'premium_plan', to: 'webhooks#premium_plan'
end
