Rails.application.routes.draw do
  devise_for :accounts
  root to: 'channels#index'

  resources :channels, only: %i(show new create)
  resources :places, only: %i(show new create edit update) do
    resources :notes, only: %i(new create edit update destroy)
  end
end
