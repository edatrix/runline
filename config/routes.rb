require 'resque/server'

Runline::Application.routes.draw do
  mount Resque::Server.new, at: "/resque"
  
  root "home_page#index"

  get "/login" => redirect("/auth/mapmyfitness"), as: :login
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboards#show"
  get "/no-runs", to: "dashboards#no_runs", as: :no_runs
  get "/compare/:id", to: "compare#show", as: :compare
  get "/profile", to: "profile#show"
  get "/fetch-runs", to: "dashboards#fetch_runs", as: :fetch_runs

  resources :users
  
  resources :friendships, only: [:index, :delete, :update] do
    collection do
      get :requests
    end

    member do
      put :approve
      delete :remove
      delete :reject
      delete :cancel
    end
  end
  delete "/friendships", to: "friendships#destroy"
  post "/friendships", to: "friendships#create", as: :add_friend

  resources :invites, :only => [:create]

end
