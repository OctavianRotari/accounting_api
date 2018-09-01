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
          get 'payments', to: 'sanctions_payments#index'
          post 'payments', to: 'sanctions_payments#create'
        end

        resources :employees, shallow: true do
          resources :salaries do
            get 'payments', to: 'salaries_payments#index'
            post 'payments', to: 'salaries_payments#create'
          end
        end

        resources :vendors, shallow: true do 
          resources :invoices, shallow: true do
            delete 'line_item/:id', to: 'invoices#destroy_line_item'
            get 'payments', to: 'invoices_payments#index'
            post 'payments', to: 'invoices_payments#create'
          end

          resources :active_invoices, shallow: true do
            delete 'sold_line_item/:id', to: 'active_invoices#destroy_sold_line_item'
            get 'payments', to: 'active_invoices_revenues#index'
            post 'payments', to: 'active_invoices_revenues#create'
          end
        end

        get 'vendors/:id/fuel_receipts', 
          to: 'vendors#fuel_receipts', 
          as: 'vendor_fuel_receipts'

        resources :vehicles, shallow: true do
          resources :fuel_receipts
          resources :maintenances, controller: "vehicle_maintenances"
        end

        get 'vehicles/:id/sanctions', 
          to: 'vehicles#sanctions', 
          as: 'vehicles_sanctions'

        get 'vehicles/:id/financial_contributions', 
          to: 'vehicles#financial_contributions', 
          as: 'vehicle_financial_contributions'

        get 'vehicles/:id/invoices', 
          to: 'vehicles#invoices', 
          as: 'vehicle_invoices'

        resources :payments, only: [:show, :edit, :update, :destroy], controller: "payments"
        resources :vehicle_types
      end
    end
  end
end
