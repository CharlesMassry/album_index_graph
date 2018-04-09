Rails.application.routes.draw do
  root "searches#index"
  get "/search", to: "searches#show"
end
