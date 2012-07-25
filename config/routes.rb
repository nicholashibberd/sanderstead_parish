SandersteadParish::Application.routes.draw do
  
  scope ':church_id' do
    resources :sermons, :only => [:show, :index]
    resources :notices, :only => [:show, :index]
  end

  scope 'admin' do
    resources :images
    resources :nav_menus do
      resources :nav_items
    end
    resources :users do
      member do
        get :change_password
      end
    end
    match '/pages', :to => 'pages#all_pages'
  end
  
  resources :sessions, :only => [:create]

  scope 'admin/:church_id' do
    resources :pages do
      resources :widgets
    end
    resources :sermons, :except => [:show, :index], :as => :admin_sermons
    resources :notices, :except => [:show, :index], :as => :admin_notices
    resources :events
    match '/sermons', :to => 'sermons#admin_index'
    match '/notices', :to => 'notices#admin_index'
  end
  
  match '/signin', :to => 'sessions#new', :as => :signin
  match '/signout', :to => 'sessions#destroy', :as => :signout
    
  post "/order_nav_items", :to => 'nav_menus#order_nav_items', :as => :order_nav_items
  post '/order_widgets', :to => 'pages#order_widgets', :as => :order_widgets
  post '/add_region', :to => 'pages#add_region', :as => :add_region
  
  get '/admin/:church_id', :to => 'admin#church_home', :as => :admin_church_home

  # Routes in the host application
  #get '../pages/:id', :to => 'pages#show'
  
  
  # Routes in the host application
  get '/pages/:id', :to => 'pages#show'
  match '/', :to => 'pages#home', :as => :root
  match '/test', :to => 'pages#test', :as => :test
  
  get ':church_id/:id', :to => 'pages#show', :as => :page_show
  
  get '/', :to => 'pages#show', :church_id => 'parish', :id => 'home', :as => :parish_home
  get '/all-saints', :to => 'pages#show', :church_id => 'all-saints', :id => 'welcome', :as => :all_saints_home
  get '/st-marys', :to => 'pages#show', :church_id => 'st-marys', :id => 'welcome', :as => :st_marys_home
  get '/st-edmunds', :to => 'pages#show', :church_id => 'st-edmunds', :id => 'welcome', :as => :st_edmunds_home
  get '/st-antonys', :to => 'pages#show', :church_id => 'st-antonys', :id => 'welcome', :as => :st_antonys_home
  

end
