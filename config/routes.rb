Rails.application.routes.draw do
  root 'items#top'
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
