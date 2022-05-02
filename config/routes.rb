# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices do
    resources :items, except: :show
  end
  resources :orders do
    resources :items, except: :show
  end
end
