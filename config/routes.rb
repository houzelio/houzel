Houzel::Application.routes.draw do
  root to: "application#index"

  resources :patient
  resources :calendar, :except => [:index]
end