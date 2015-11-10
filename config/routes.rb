Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#home'
  devise_for :users, controllers: { registrations: "registrations" }
  devise_for :admins
end
