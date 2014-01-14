Runline::Application.routes.draw do
  root "home_page#index"

  match "/login" => redirect("/auth/mapmyfitness"), as: :login, via: :get
  match "/auth/:provider/callback", to: "sessions#create", via: :get
  match "/logout", to: "sessions#destroy", via: :get

  match "/dashboard", to: "dashboards#show", via: :get

  resources :users
  
  resources :friendships, only: [:index, :create, :delete, :update] do
    collection do
      get :requests
    end

    member do
      put :approve
      delete :remove
    end
  end
    get "/friendships" => "friendships#index"
    delete "/friendships" => "friendships#destroy"
    put "/friendships" => "friendships#update"
    #get "/requests" => "friendships#requests"

end
