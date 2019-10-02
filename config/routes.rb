Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "sign-up", to: "auth#create"
  post "login", to: "auth#login"

  get "projects", to: "projects#index"
  post "projects", to: "projects#create"
  delete "projects/:id", to: "projects#destroy"

  get "projects/:project_id/tasks", to: "tasks#index"
  post "projects/:project_id/tasks", to: "tasks#create"
  delete "projects/:project_id/tasks/:id", to: "tasks#destroy"
  put "projects/:project_id/tasks/:id", to: "tasks#update"
end
