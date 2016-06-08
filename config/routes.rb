Rails.application.routes.draw do
  get 'home/index'
  get 'welcome/index'

  devise_for :users

  authenticated :user do
    root 'welcome#index', as: :authenticated_root
  end

  # get :find_cities, on: :collection

  resources :contacts, only: [:create, :show, :index, :delete]

  root 'home#index' # to: redirect('/users/sign_in')
end
