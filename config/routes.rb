Rails.application.routes.draw do
  resources :trees, only: [:index, :show], defaults: { format: :json } do
    resources :nodes, only: [:index, :show] do
      member do
        get 'children_ids'
        get 'parents_ids'
      end
    end
  end

  root 'trees#index', defaults: { format: :json }
end
