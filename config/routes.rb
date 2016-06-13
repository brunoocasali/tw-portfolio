Rails.application.routes.draw do
  # friendly url here.
  resources :project_galleries, param: :code, only: [:update, :index] do
    get :unlock, on: :collection

    member do
      get :locked
    end
  end

  resources :welcome, only: :index do
    get :sessions, on: :collection
  end

  devise_for :users

  authenticated :user do
    root 'welcome#index', as: :authenticated_root
  end

  # admin only:
  resources :contacts, only: [:create, :show, :index, :delete]

  resources :galleries, only: :none do
    resources :media, only: [:index, :create, :destroy]
  end

  resources :utils, only: :none do
    get 'complete_address/:zipcode', action: :complete_address, on: :collection
  end

  resources :clients do
    resources :projects, except: :show do
      get :dashboard, on: :member

      resources :newsletters, only: :index
      resources :sessions, only: [:destroy, :create, :index] do
        member do
          get :wait
          get :cancel
          get :finish
        end
      end

      resources :galleries, except: :show
      resources :print_requests
    end
  end

  root 'home#index' # to: redirect('/users/sign_in')
end
