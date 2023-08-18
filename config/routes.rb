Rails.application.routes.draw do
  root 'items#top'

  resources :items do
    collection do
      get 'top'
      get 'search_rakuten'
    end
    resource :likes, only: [:create, :destroy]
    get 'liked_users', on: :member
    resources :comments, only: [:create, :destroy, :index]
  end

  devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      sessions: 'users/sessions'
    }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:index] do
    member do
      get 'myitems', to: 'users#show_myitems', as: 'myitems'
      get 'favorites', to: 'users#show_favorites', as: 'favorites'
      get 'profile/edit', to: 'users#edit_profile', as: 'edit_profile'
      get 'account', to: 'users#account', as: 'account'
    end
  end

  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'contact', to: 'static_pages#contact', as: :contact
  get 'searches', to: 'searches#index'
end
