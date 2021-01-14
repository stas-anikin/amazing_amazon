Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/", { to: "welcome#home", as: :root })

  resources :products do
    resources :reviews, only: [:create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
end
