Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "v1/short_links#new"

  namespace :v1 do
    resource :session
    resource :registration
    resources :short_links
    resources :impressions
    resources :user_api_keys
    get "empty_table", to: "impressions#empty_table"
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "token/access", to: "tokens#create"
      post "token/refresh", to: "tokens#refresh"
      post "url/shorten", to: "urls#create"
    end
  end

  get ":shorten_url", to: "v1/short_links#redirect"
end
