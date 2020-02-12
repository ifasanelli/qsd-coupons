Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :promotions, only: %i[index show new create edit update] do
    post 'approve', on: :member, to: 'promotions#approve'
    post 'generate_coupons', on: :member, to: 'promotions#generate_coupons'
    post 'generate_singles', on: :member, to: 'promotions#generate_singles'
    resources :coupons, only: %i[index create show] do
      get 'discard', on: :member, to: 'coupons#discard'
    end
    resources :record_approvals, only: %i[index create show]
  end
  resources :record_approvals, only: %i[index]
end
