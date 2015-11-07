Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#home'
  devise_for :users, controllers: { registrations: "registrations" }
end
