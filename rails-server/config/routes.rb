Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth' => 'auth#create'
      post 'logout' => 'auth#destroy'
      get 'auth' => 'auth#index'
    end
    # final route to catch invalid urls
    match '*path', to: 'base#not_found', via: :all
  end
end
