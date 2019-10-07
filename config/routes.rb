Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "sign-up", to: "auth#create"
  post "login", to: "auth#login"

  resources :projects, only: [:index, :create, :destroy, :update] do
    resources :tasks, only: [:index, :create, :destroy, :update] do
      put 'move_higher'
      put 'move_lower'
    end
  end

  # get "projects", to: "projects#index"
  # post "projects", to: "projects#create"
  # delete "projects/:id", to: "projects#destroy"
  # put "projects/:id", to: "projects#update"

  # get "projects/:project_id/tasks", to: "tasks#index"
  # post "projects/:project_id/tasks", to: "tasks#create"
  # delete "projects/:project_id/tasks/:id", to: "tasks#destroy"
  # put "projects/:project_id/tasks/:id", to: "tasks#update"
  # put "projects/:project_id/tasks/:id/move_higher", to: 'tasks#move_higher'
  # put "projects/:project_id/tasks/:id/move_lower", to: 'tasks#move_lower'
  
end
