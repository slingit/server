Rails.application.routes.draw do
  root "homes#show"
  resources :devices, only: [:index, :show, :create, :update]
end
