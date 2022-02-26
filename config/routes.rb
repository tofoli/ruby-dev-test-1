Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post 'folders', to: 'folders#create'
  put 'folders/:id', to: 'folders#update'

  get 'folders', to: 'folders#root'
  get 'folders/:id', to: 'folders#childers'

  get 'folders/:folder_id/files', to: 'files#index'
  post 'folders/:folder_id/files', to: 'files#create'
  delete 'folders/:folder_id/files/:id', to: 'files#destroy'
end
