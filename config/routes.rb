Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [] do
    resources :clock_ins, only: [:index, :create]
    post 'touch_relationship/:target_user_id' => 'users#touch_relationship'
  end
end
