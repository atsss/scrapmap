Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :accounts
  root to: 'front/communities#show'

  scope module: 'front' do
    resources :channels, only: %i(show new create)
    resources :places, only: %i(show new create edit update) do
      resources :notes, only: %i(new create edit update destroy)
    end
  end
end
