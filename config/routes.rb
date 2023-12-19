Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    get 'users/current', to: 'users#current'

    resources :tesla_models do
      member do
        get 'image'
      end
      resources :reservations, only: [:create, :index]
    end

    resources :users, only: [:index, :create, :show]
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :reservations, only: [:show, :update, :destroy]
    get 'user_reservations', to: 'reservations#user_reservations'
  end
end
