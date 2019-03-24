Rails.application.routes.draw do
  resources :trees, only: [:index, :show], defaults: { format: :json } do
    resources :nodes, only: [:index, :show]
  end

  root 'trees#index', defaults: { format: :json }
end
