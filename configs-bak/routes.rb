DurstPortal::Application.routes.draw do
  get '/search', to: 'search#index', as: :search

  devise_for :users, controllers: { confirmations: :confirmations, sessions: :sessions }
  devise_scope :user do
    patch '/confirm' => 'confirmations#confirm'
    get '/login' => 'sessions#login'
  end

  authenticate :user, ->(user) { user.admin? } do
    mount DelayedJobWeb, at: '/delayed_job'
  end

  get '/sitemap', to: 'sitemap#show'

  get '/', to: 'teasers#show',    constraints: ->(req) { Hostname.property_teasers.matchable_with?(req.host) }
  Commercial::Router.load!
  get '/', to: 'properties#show', constraints: ->(req) { Hostname.properties.matchable_with?(req.host) }
  get '/', to: 'portfolios#show', constraints: ->(req) { Hostname.portfolios.matchable_with?(req.host) }

  root 'portfolios#index'

  get '/status', to: 'status#current'
  get '/signature', to: 'signatures#show'

  resources :tenants, except: :show

  resources :tenant_employees, except: [:index, :show]

  resources :portfolios, only: [:index, :show]

  resources :properties do
    resource :inquiries, only: [:create]
  end

  resource :taking_inquiries, only: [:create]

  resource :applications, only: [:create]

  resources :news, only: [:index, :show], param: :news_id

  resources :availabilities, only: [:show] do
    get :search, on: :collection
    resources :pdfs, controller: 'availabilities/pdfs', only: :show
  end

  resources :interests, only: [:create, :update] do
    get :reset, action: :reset, on: :collection
  end

  resources :permits, only: [:index]

  get 's/:token' => 'interests#edit', as: :edit_interest

  resources :appointments, only: [:create]
  delete 'appointments/:token', to: 'appointments#destroy', as: :appointment

  get 'inquiries/thanks', to: 'inquiries#thanks', as: :inquiry_thanks

  get 'privacy', to: 'static#privacy'

  get 'unsubscribe_user', to: 'unsubscribe_user#unsubscribe', as: :unsubscribe_user

  namespace :api do
    namespace :mits do
      resource :on_site_v3, only: [:create], path: '3.0', controller: 'on_site_v3'
    end
  end

  resources :users

  namespace :admin do
    root 'properties#index'

    get '/resources', to: 'root#index'

    resources :users do
      resources :send_interests, only: :update
      member do
        patch 'restore'
      end
    end

    post 'create/:user_id/:property_id', to: 'guest_cards#create', as: 'guest_cards'

    resources :portfolios, except: [:destroy]

    resources :news do
      resources :properties do
        resources :send_news_item_emails, only: [:create]
      end
    end
    resources :audits

    resources :properties, except: [:destroy] do
      resources :sights, only: [:index, :edit, :update, :destroy]
      resources :news
      resources :permits
      resources :nestio_listings, only: [:index]
      resources :sections, only: [:show, :edit, :update]
      resources :units, except: [:show, :destroy]
      resources :floorplan_types
      resources :import_users, only: [:new, :create]
      resource :appointments_calendar, only: [:show, :update], controller: 'appointments_calendar'
      collection do
        resources :appointments, only: [:index, :edit, :update] do
          member do
            get :ics_download
            get :cancel_confirmation
            delete :cancel

            get :confirm_confirmation
            post :confirm
            post :schedule
          end
        end

        resources :inquiries, only: :index do
          get 'export', action: :export, on: :collection
        end
      end
      resources :downloadable_assets, only: [:index]
    end

    resources :csv, only: [] do
      get 'download/:resource', action: :download, on: :collection, as: :download
    end
  end
end
