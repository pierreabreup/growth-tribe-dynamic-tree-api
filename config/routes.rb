Rails.application.routes.draw do
  resources :trees, only: [:index, :show], defaults: { format: :json }

  root 'trees#index', defaults: { format: :json }
end
