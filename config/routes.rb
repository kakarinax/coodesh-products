Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/' => 'api_status#index'
      put '/products/:code' => 'products#update'
      get '/products/:code' => 'products#show'
      get '/products' => 'products#index'
      delete '/products/:code' => 'products#delete'
    end
  end
end
