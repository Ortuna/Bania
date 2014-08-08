Rails.application.routes.draw do
  root 'welcome#index'

  get 'track', to: 'track#create'

end
