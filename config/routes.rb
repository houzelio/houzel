Houzel::Application.routes.draw do
  root to: "application#index"

  resources :patient
end
