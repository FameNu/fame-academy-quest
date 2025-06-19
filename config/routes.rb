Rails.application.routes.draw do
  root "pages#index"

  get "/pages", to: redirect("/"), as: :quests
  get "/brag", to: "pages#brag", as: :brag
  get "up" => "rails/health#show", as: :rails_health_check
end
