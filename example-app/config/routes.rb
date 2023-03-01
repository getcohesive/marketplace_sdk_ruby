Rails.application.routes.draw do
  root "articles#index"
  get "/articles", to: "articles#index"
  get "/cohesive_login", to: "cohesive#login"
end
