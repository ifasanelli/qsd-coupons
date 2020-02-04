Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :promotions, only: [:show] do
    resources :coupons, only: [:index, :create, :show, :destroy]
  end
end
