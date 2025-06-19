Rails.application.routes.draw do
  root "pages#index"

  resources :quests, only: [ :create, :update, :destroy ]
  get "/pages", to: redirect("/"), as: :index
  get "/brag", to: "pages#brag", as: :brag
  get "up" => "rails/health#show", as: :rails_health_check
end
