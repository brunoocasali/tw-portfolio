Rails.application.routes.draw do
  resources :project_galleries, path: 'ensaios', param: :code, only: :update do
    collection do
      post :unlock
      get :unlock
    end

    member do
      get :locked
      get :index

      get :download
    end
  end

  resources :works, path: 'trabalhos'

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
    resources :media, only: [:index, :create, :destroy, :update]
  end

  resources :utils, only: :none do
    get 'complete_address/:zipcode', action: :complete_address, on: :collection
  end

  resources :clients do
    resources :projects, except: :show do
      get :dashboard, on: :member
      post :deliver, on: :member

      resources :newsletters, only: :index do
        collection do
          post :mail_about_work
          post :mail_project_almost_done
        end
      end

      resources :sessions, only: [:create, :index] do
        member do
          get :wait
          get :cancel
          get :finish
          get :remove
        end
      end

      resources :galleries, except: :show
      resources :print_requests
    end
  end

  root 'home#index'
  match ':code', to: 'project_galleries#index', via: :get
end
