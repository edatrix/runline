Runline::Application.routes.draw do
  root "home_page#index"

  get "/login" => redirect("/auth/mapmyfitness"), as: :login
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboards#show"
  get "/compare/:id", to: "compare#show", as: :compare
  get "/profile", to: "profile#show"

  resources :users
  
  resources :friendships, only: [:index, :delete, :update] do
    collection do
      get :requests
    end

    member do
      put :approve
      delete :remove
      delete :reject
    end
  end
  delete "/friendships", to: "friendships#destroy"
  post "/friendships", to: "friendships#create", as: :add_friend

  #post "/invites", to: "invites#send", as: :send_invite
  resources :invites, :only => [:create]

end
