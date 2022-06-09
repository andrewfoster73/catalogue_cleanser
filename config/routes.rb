# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products
  resources :product_duplicates
  resources :actions
  resources :comments
  resources :abbreviations
  resources :dictionary_entries
  resources :brand_aliases
  resources :brands
  resources :item_pack_aliases
  resources :item_packs
  resources :item_measure_aliases
  resources :item_measures
  resources :item_sell_pack_aliases
  resources :item_sell_packs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
