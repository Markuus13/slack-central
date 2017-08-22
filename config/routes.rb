Rails.application.routes.draw do
  # Listens for socket requests
  mount ActionCable.server => '/test'

  root 'welcome#index'

  resources :quotes, only: [:index, :create]

  scope "projects" do
    post "/", to: "projects#create"
    post "/destroy", to: "projects#destroy"
    get '/', to: "projects#index"
  end

  scope "users" do
    post "/", to: "users#create"
    post "/destroy", to: "users#destroy"
    post "/allocate", to: "users#allocate"
  end
end
