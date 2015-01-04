Rails.application.routes.draw do
  resources :devices, only: [:show, :create, :update]
end
