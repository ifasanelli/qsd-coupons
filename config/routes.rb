Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'promotions#index'

  resources :promotions, only: %i[index show new create edit update] do
    post 'approve', on: :member, to: 'promotions#approve'
    post 'generate_coupons', on: :member, to: 'promotions#generate_coupons'
    resources :coupons, only: %i[index create show destroy] do
      get 'discard', on: :member, to: 'coupons#discard'
    end
    resources :record_approvals, only: %i[index create show]
  end
  resources :record_approvals, only: %i[index]

  namespace :api do
    namespace :v1 do
      resources :coupons, only: %i[index show create update destroy] do
        get 'confer', on: :collection
      end
      resource :coupon, only: [] do
        post ':code/burn', to: 'coupons#burn'
      end
    end
  end
end
