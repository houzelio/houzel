Houzel::Application.routes.draw do
  root to: "application#index"

  if Sequel::Model.db.table_exists?(:user)
    devise_for :user, controllers: { registrations: "registration", sessions: "session" },
      skip: [:registration, :session]
  end

  devise_scope :user do
    get    "signin",  to: "session#new",         as: :new_user_session
    post   "signin",  to: "session#create",      as: :user_session
    delete "signout", to: "session#destroy",     as: :destroy_user_session

    get    "signup",  to: "registration#new",    as: :new_user_registration
    post   "signup",  to: "registration#create", as: :user_registration
  end

  resources :user, only: :destroy
  resources :patient
  resources :calendar, :except => [:index]
end
