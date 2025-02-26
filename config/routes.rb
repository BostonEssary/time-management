Rails.application.routes.draw do
  get "ratings/create"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "dashboard#show"

  concern :searchable do
    get :search, on: :collection
  end

  resource :dashboard
  resources :follows, only: [ :create, :destroy ]
  resources :users, only: [ :show, :edit, :update ]
  resource :profile, only: [ :show, :edit, :update ]
  resources :flowers
  resources :concentrates
  resources :edibles
  resources :pre_rolls
  resources :brands, concerns: :searchable
  resources :ratings, only: [ :new, :create ]
  resources :ratings do
    resource :like, only: [:create, :destroy]
  end
  namespace :api do
    resources :brands, only: [ :index ]
  end
end
