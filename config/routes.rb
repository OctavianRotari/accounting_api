Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
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
          resources :insurances, shallow: true do
            resources :insurance_receipts
          end

          resources :credit_notes, shallow: true do
            get 'revenues', to: 'credit_notes_revenues#index'
            post 'revenues', to: 'credit_notes_revenues#create'
          end

          resources :invoices, shallow: true do
            resources :line_items, shallow: true, only: [:update, :destroy, :show]
            get 'payments', to: 'invoices_payments#index'
            post 'payments', to: 'invoices_payments#create'
          end

          resources :active_invoices, shallow: true do
            resources :sold_line_items, shallow: true, only: [:update, :destroy, :show]
            get 'revenues', to: 'active_invoices_revenues#index'
            post 'revenues', to: 'active_invoices_revenues#create'
          end
        end

        get 'vendors/:id/fuel_receipts', 
          to: 'vendors#fuel_receipts', 
          as: 'vendor_fuel_receipts'

        resources :vehicles, shallow: true do
          resources :fuel_receipts
          resources :loads
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

        get 'vehicles/:id/insurances', 
          to: 'vehicles#insurances', 
          as: 'vehicle_insurances'

        get 'vehicles/:id/active_insurance', 
          to: 'vehicles#active_insurance', 
          as: 'vehicle_active_insurance'

        resources :payments, only: [:show, :edit, :update, :destroy], controller: "payments"
        resources :revenues, only: [:show, :edit, :update, :destroy], controller: "revenues"
        resources :vehicle_types
      end
    end
  end
end
