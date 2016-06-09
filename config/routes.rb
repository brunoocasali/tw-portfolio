Rails.application.routes.draw do
  get 'home/index'
  get 'welcome/index'

  devise_for :users

  authenticated :user do
    root 'welcome#index', as: :authenticated_root
  end

  resources :contacts, only: [:create, :show, :index, :delete]

  resources :clients do
    get :dashboard, on: :member
    get 'complete_address/:zipcode', action: :complete_address, on: :collection

    resources :projects do
      get :dashboard, on: :member

      resources :newsletters
      resources :sessions
      resources :galleries
      resources :print_requests
    end
  end

  root 'home#index' # to: redirect('/users/sign_in')
end
