Rails.application.routes.draw do
  root to: 'channels#index'

  resources :channels, only: %i(show new create)
  resources :places, only: %i(show new create) do
    resources :notes, only: %i(new create)
  end
end
