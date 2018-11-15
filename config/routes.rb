Rails.application.routes.draw do
  get 'landing/one'
  get 'landing/two'
  get 'landing/three'
  root 'home#index'

  get 'FAQ', to: 'home#faq'
  get 'Profil', to: 'home#profil'
  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session


  end

end
