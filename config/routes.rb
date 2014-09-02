require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'
  resources :events, only: :create
  mount Sidekiq::Web => '/sidekiq'
end
