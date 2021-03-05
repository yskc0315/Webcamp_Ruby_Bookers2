Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations" }
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

  resources :users, only: [:show, :index, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end

  resources :books, only: [:create, :show, :edit, :index, :destroy, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end
end