Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  mount_devise_token_auth_for 'User', at: 'auth'

  scope module: 'api' do
    namespace :v1 do
      constraints format: :json do
        resources :financial_contributions
        resources :contribution_types
        resources :other_expenses
        resources :sanctions do
          resources :payments, controller: "sanctions_payments"
        end
        resources :employees do
          resources :salaries do
            resources :payments, controller: "salaries_payments"
          end
        end
        resources :vendors do 
          resources :invoices do
            resources :payments, controller: "invoices_payments"
          end
        end
        resources :vehicles do
          resources :maintenances, controller: "vehicle_maintenances"
        end
        resources :vehicle_types
      end
    end
  end
end
