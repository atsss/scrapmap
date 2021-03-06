Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :accounts, controllers: {
    omniauth_callbacks: 'accounts/omniauth_callbacks'
  }
  root to: 'front/communities#show'

  scope module: 'front' do
    resources :channels, only: %i(show new create edit update)
    resources :places, only: %i(show new create edit update) do
      resources :notes, only: %i(new create edit update destroy)
      resource :copy, only: %i(new create)
    end
    resource :draft, only: %i(new create)
  end
end
