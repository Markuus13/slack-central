Rails.application.routes.draw do
  root 'welcome#index'

  resources :quotes, only: [:index, :create]
end
