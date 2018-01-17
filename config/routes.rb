Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      
    end
  end
  resources :api_clients
  resources :api_keys
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'home#index'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
