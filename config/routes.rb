Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      delete "/logout", to: "sessions#destroy"
      get "/logged_in", to: "sessions#logged_in"
      resources :registrations, only: [:create]
    end
  end
   
  # delete :logout, to: "sessions#logout"
  root to: "static#home"
end
