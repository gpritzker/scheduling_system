# config/routes.rb
Rails.application.routes.draw do
  resources :doctors, only: [:show] do
    get 'availabilities', to: 'availabilities#index'
    get 'working_hours', on: :member
    resources :availabilities, only: [:index]
    resources :appointments, only: [:create, :update, :destroy]
  end
end
