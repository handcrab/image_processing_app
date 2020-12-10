Rails.application.routes.draw do
  resources :images, only: :none do
    post :compress, on: :collection
    get :download, on: :member
  end

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end
