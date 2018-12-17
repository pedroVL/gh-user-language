Rails.application.routes.draw do
  root to: 'searches#search'
  get 'search', to: 'searches#search', as: :search
  get 'result', to: 'searches#result', as: :result
end
