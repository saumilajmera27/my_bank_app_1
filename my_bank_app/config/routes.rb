Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "user#index"
  get 'home_page', to: 'user#home'
  get 'open_account', to: 'user#open_account'
  get 'deposit_form', to: 'account#deposit_form'
  get 'withdraw_form', to: 'account#withdraw_form'
  get 'transfer_form', to: 'account#transfer_form'
  get 'transactions', to: 'account#transaction'
  post 'deposit', to: 'account#deposit'
  post 'withdraw', to: 'account#withdraw'
  post 'transfer', to: 'account#transfer'
end
