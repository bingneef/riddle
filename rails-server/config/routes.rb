Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'login' => 'auth#google_auth'
      post 'login' => 'auth#login'
      post 'logout' => 'auth#destroy'
      get 'auth' => 'auth#index'
      post 'socket_transmit' => 'auth#socket_transmit'

    end


    # final route to catch invalid urls
    match '*path', to: 'base#not_found', via: :all
  end
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
