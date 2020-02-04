Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :promotions, only: %i[index show new create edit update] do
    resources :coupons, only: %i[index create show destroy]
  end
end
