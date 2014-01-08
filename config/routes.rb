Runline::Application.routes.draw do
  root "home_page#index"

  match "/login" => redirect("/auth/twitter"), as: :login, via: :get
  match "/auth/:provider/callback", to: "sessions#create", via: :get

  resources :users
end
