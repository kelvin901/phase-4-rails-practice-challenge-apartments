Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
  root to: 'pages#home'

  resources :apartments 
  # end
  resources :tenants 
  resources :leases, only: [:new, :create, :destroy]
    # resources :apartments, only: [:index, :show]
  # end
  # resources :leases, only: [:new, :create, :destroy, :show]
  # resources :apartments do 
  #   resources :tenants, shallow: true, only: [:show, :index]
  #   resources :leases, shallow: true, only: [:new, :create, :destroy]
  # end 
  # resources :tenants do 
  #   resources :apartments, shallow: true, only: [:show, :index]
  #   resources :leases, shallow: true, only: [:new, :create, :destroy]
  # end 

  # resources :leases, shallow: true, only: [:new, :create, :destroy] do 
  #   resources :apartments, shallow: true 
  #   resources :tenants, shallow: true 
  # end 

end