# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  resources :line_items
  resources :carts
  resources :rods do
    match '/scrape', to: 'rods#scrape', via: :post, on: :collection
  end
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  get 'search', to: 'rods#search', as: 'search'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  root 'rods#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
