# config/routes.rb
Rails.application.routes.draw do
  resources :doctors do
    get 'available_slots', to: 'availabilities#index', on: :member
    get 'working_hours', on: :member
    resources :availabilities, only: [:index]
    resources :appointments, only: [:create, :update, :destroy]
  end
end
