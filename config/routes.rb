Rails.application.routes.draw do
  root to: 'places#index'

  resources :places, only: %i(show new create) do
    resources :notes, only: %i(new create)
  end
end
