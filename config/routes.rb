# frozen_string_literal: true

Rails.application.routes.draw do
  # Authentication
  get '/auth/:provider/callback' => 'sessions#omniauth'
  delete '/sessions/logout' => 'sessions#destroy'

  # Dashboard
  get '/dashboard' => 'dashboard#index'
  get '/dashboard/percentage_products_with_issues_vs_none' => 'dashboard#percentage_products_with_issues_vs_none'
  get '/dashboard/percentage_products_used_vs_not_used' => 'dashboard#percentage_products_used_vs_not_used'
  get '/dashboard/products_created_by_month' => 'dashboard#products_created_by_month'
  get '/dashboard/product_issues_by_type' => 'dashboard#product_issues_by_type'
  get '/dashboard/tasks_completed_by_day' => 'dashboard#tasks_completed_by_day'

  # Calendar
  get '/calendar' => 'calendar#index'

  concern :audited do
    resources :audits, only: %i[index]
  end

  resources :users, only: %i[index show edit update], concerns: %i[audited]

  resources :tasks
  resources :products, shallow: true, except: %i[new create], concerns: %i[audited] do
    resources :product_translations, only: %i[index create]
    resources :product_issues, only: %i[index]
    resources :product_duplicates, only: %i[index]
  end
  resources :product_translations, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :product_issues, only: %i[index]
  end
  resources :product_issues, only: %i[index update destroy]
  resources :product_duplicates, only: %i[index update destroy], concerns: %i[audited]
  resources :comments
  resources :abbreviations
  resources :dictionary_entries
  resources :brand_aliases, except: %i[new]
  resources :brands, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :brand_aliases, only: %i[index create]
  end
  resources :item_pack_aliases, except: %i[new]
  resources :item_packs, shallow: true, except: %i[new], concerns: %i[audited] do
    resources :item_pack_aliases, only: %i[index create]
  end
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
