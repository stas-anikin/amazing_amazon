Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/", { to: "welcome#home", as: :root })
  get("/admin/panel", to: "welcome#admin_panel")
  resources :products do
    resources :reviews
  end
  resources :news_articles, only: [:new, :create, :show, :index, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
end
