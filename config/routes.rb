Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/home", to: "welcome#home")
  get("/users/:id/favourites", to: "users#favoured", as: "favourites")
  get("/about", to: "welcome#about")
  get("/", { to: "welcome#home", as: :root })
  get("/admin/panel", to: "welcome#admin_panel")
  resources :products do
    resources :reviews, shallow: true, only: [:create, :destroy] do
      get :liked, on: :collection
      resources :likes, only: [:create, :destroy]
      get :voted, on: :collection
      resources :votes, only: [:create, :destroy]
    end
    # get :favoured, on: :collection

    resources :favourites, shallow: :true, only: [:create, :destroy]
  end
  resources :news_articles, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :tags, only: [:index, :show]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [:index, :show, :update, :create, :destroy]
      resource :session, only: [:create, :destroy]
    end
  end
end
