Rails.application.routes.draw do
  resources :images, only: :none do
    post :compress, on: :collection
    get :download, on: :member
  end

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end
end
