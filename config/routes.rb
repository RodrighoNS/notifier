Notifier::Engine.routes.draw do
  resources :email_channels
  resources :email_notifications
end
