ExpenseManager::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root to: "home#index"
  resources :users ,:only => [:show]
  resources :transactions
  resources :group_members
  resources :groups

end
