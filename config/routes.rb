Rails.application.routes.draw do
  # Listens for socket requests
  mount ActionCable.server => '/test'

  root 'welcome#index'

  resources :quotes, only: [:index, :create]
end
