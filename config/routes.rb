Rails.application.routes.draw do
  devise_for :users, controllers: { "registrations" }
  root 'welcome#index'
end
