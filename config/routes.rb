Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :devices, only: :create
      resources :messages, only: :create do
      	resource :content, only: :show
      end
    end
  end
end
