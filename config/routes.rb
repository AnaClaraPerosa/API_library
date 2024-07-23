Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:new, :edit]
      resources :authors, except: [:new, :edit]
      resources :categories, except: [:new, :edit]
      resources :books, except: [:new, :edit]
      resources :reservations, except: [:new, :edit]
      resources :loans, except: [:new, :edit]
    end
  end
end
