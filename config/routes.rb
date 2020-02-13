Houzel::Application.routes.draw do
  root to: redirect('/patient')

  if DatabaseTester.has_connection?
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

  resources :user, only: %i(update destroy)
  resources :patient
  resources :visit
  resources :appointment
  resources :medical_history, only: :index
  resources :service
  resources :invoice

  scope "admin", controller: :admin do
    get :users_role, path: "/users"
  end

  scope "user" do
    resources :profile, only: :update do
      collection do
        get "/", action: :show
        get "/email", to: redirect('/user/profile')
        get "/password", to: redirect('/user/profile')
      end
    end
  end
end
