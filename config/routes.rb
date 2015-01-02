Rails.application.routes.draw do
  resources :devices, only: [:create]
end
