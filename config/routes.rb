Rails.application.routes.draw do
  root to: 'searches#search'
  get 'search', to: 'searches#search', as: :search
  get 'result', to: 'searches#result', as: :result
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
