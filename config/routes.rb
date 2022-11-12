# frozen_string_literal: true

Rails.application.routes.draw do
  # Authentication
  get '/auth/:provider/callback' => 'sessions#omniauth'
  delete '/sessions/logout' => 'sessions#destroy'

  # Dashboard
  get '/dashboard' => 'dashboard#index'

  # Calendar
  get '/calendar' => 'calendar#index'

  concern :audited do
    resources :audits, only: %i[index]
  end

  resources :users, only: %i[show edit update], concerns: %i[audited]

  resources :tasks
  resources :products, shallow: true, except: %i[new create], concerns: %i[audited] do
    resources :product_translations, only: %i[index create]
    resources :product_issues, only: %i[index]
  end
  resources :product_translations, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :product_issues, only: %i[index]
  end
  resources :product_issues, only: %i[index update destroy]
  resources :product_duplicates
  resources :comments
  resources :abbreviations
  resources :dictionary_entries
  resources :brand_aliases, except: %i[new]
  resources :brands, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :brand_aliases, only: %i[index create]
  end
  resources :item_pack_aliases
  resources :item_packs
  resources :item_measure_aliases, except: %i[new]
  resources :item_measures, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :item_measure_aliases, only: %i[index create]
  end
  resources :item_sell_pack_aliases, except: %i[new]
  resources :item_sell_packs, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :item_sell_pack_aliases, only: %i[index create]
  end

  # Defines the root path route ("/")
  root 'landing#root'
end
