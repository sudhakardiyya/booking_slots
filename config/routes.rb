Rails.application.routes.draw do
  root 'dashboards#index'
  resources :booking_slots
end
