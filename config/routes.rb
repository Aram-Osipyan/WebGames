Rails.application.routes.draw do
  # devise_for :admins
  root to: 'pages#home'
  namespace :api do
    namespace :users do
      resources :tokens, only: [:create]
    end
  end

  namespace :wordle do
    resource :state, only: [:show, :create]
    resource :stats, only: [:show]
    resource :price, only: [:show]
  end

  namespace :racer do
    resource :game_complete, only: [:show, :create]
    get :leaderboard, only: [:index], to: 'leaderboard#index'
  end

  get '/up/', to: 'up#index', as: :up
  get '/up/databases', to: 'up#databases', as: :up_databases
  get 'pages/test', to: 'pages#test', as: :test

  namespace :games do
    mount ActionDispatch::Static.new(
      Rails.application,
      Rails.root.join('app/views/test').to_s,
      headers: {
        'Access-Control-Allow-Origin' => '*',
        'Cross-Origin-Embedder-Policy' => 'require-corp',
        'Cross-Origin-Opener-Policy' => 'same-origin'
      }
    ), at: '/path/*other/game'

    mount ActionDispatch::Static.new(
      Rails.application,
      Rails.root.join('app/views/wordle').to_s,
      headers: {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS',
        'Cross-Origin-Embedder-Policy' => 'require-corp',
        'Access-Control-Request-Method' => '*',
        'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept, Authorization',
        'Cross-Origin-Opener-Policy' => 'same-origin'
      }
    ), at: '/*token/wordle'

    mount ActionDispatch::Static.new(
      Rails.application,
      Rails.root.join('app/views/traffic-racer').to_s,
      headers: {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS',
        'Cross-Origin-Embedder-Policy' => 'require-corp',
        'Access-Control-Request-Method' => '*',
        'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept, Authorization',
        'Cross-Origin-Opener-Policy' => 'same-origin'
      }
    ), at: '/*token/racer'
  end

  devise_for :admins, controllers: {
        sessions: 'admins/sessions',
        registrations: 'admins/registrations'
      }

  authenticate :admin do
    mount Avo::Engine, at: '/admin_panel/'
  end

  # Sidekiq has a web dashboard which you can enable below. It's turned off by
  # default because you very likely wouldn't want this to be available to
  # everyone in production.
  #
  # Uncomment the 2 lines below to enable the dashboard WITHOUT authentication,
  # but be careful because even anonymous web visitors will be able to see it!
  # require "sidekiq/web"
  # mount Sidekiq::Web => "/sidekiq"
  #
  # If you add Devise to this project and happen to have an admin? attribute
  # on your user you can uncomment the 4 lines below to only allow access to
  # the dashboard if you're an admin. Feel free to adjust things as needed.
  # require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => "/sidekiq"
  # end

  # Learn more about this file at: https://guides.rubyonrails.org/routing.html
end
