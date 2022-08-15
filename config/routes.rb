# frozen_string_literal: true

Rails.application.routes.draw do
  # Authentication
  get '/auth/:provider/callback' => 'sessions#omniauth'
  delete '/sessions/logout' => 'sessions#destroy'

  # Dashboard
  get '/dashboard' => 'dashboard#index'

  resources :tasks
  resources :products
  resources :product_duplicates
  resources :comments
  resources :abbreviations
  resources :dictionary_entries
  resources :brand_aliases
  resources :brands
  resources :item_pack_aliases
  resources :item_packs
  resources :item_measure_aliases
  resources :item_measures
  resources :item_sell_pack_aliases, except: %i[new]
  resources :item_sell_packs, shallow: true, except: %i[new] do
    resources :item_sell_pack_aliases, only: %i[index create]
  end

  # Defines the root path route ("/")
  root 'landing#root'
end
