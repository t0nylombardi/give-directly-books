# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/request', to: 'request#request_title'
      get '/request', to: 'request#index'
      get '/request/:id', to: 'request#show'
      delete '/request/:id', to: 'request#destroy'
    end
  end
end
