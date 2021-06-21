Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :リソース名 :only => [:アクション名, :アクション名, ...]
  root 'recipes#index'
  resources :recipes, :only => [:index, :show, :create, :update, :destroy]
end
