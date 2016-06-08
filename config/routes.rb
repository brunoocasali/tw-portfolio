Rails.application.routes.draw do
  get 'home/index'
  get 'welcome/index'

  devise_for :users

  authenticated :user do
    root 'welcome#index', as: :authenticated_root
  end

  # get :find_cities, on: :collection

  resources :contacts, only: [:create, :show, :index, :delete]

  resources :clients do
    get :dashboard, on: :member

    resources :projects do
      get :dashboard, on: :member
    end
  end

  root 'home#index' # to: redirect('/users/sign_in')
end
