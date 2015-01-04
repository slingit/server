Rails.application.routes.draw do
  root "homes#show"
  resources :devices, only: [:show, :create, :update]
end
