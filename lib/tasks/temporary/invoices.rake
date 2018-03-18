namespace :invoices do
  task main: [
    :move_active_invoice_to_receipts, 
    :move_vehicle_id_invoice_id_to_vehicle_line_items, 
    :move_company_id_to_company_invoice,
    :change_from_at_the_expense_of_to_general_expense,
    :move_taxable_vat_to_sold_line_items,
    :move_taxable_vat_to_line_items
  ]

  task remove: [:remove_active_invoices]

  desc 'Move all active invoices into receipts'
  task move_active_invoice_to_receipts: :environment do
    invoices = Invoice.where(type_of_invoice: 'attiva')
    puts "Going to update #{invoices.count} invoices"
    ActiveInvoice.transaction do
      invoices.each do |invoice|
        ActiveInvoice.create(
          id: invoice.id,
          date_of_issue: invoice.date_of_issue,
          deadline: invoice.deadline,
          collected: invoice.paid,
          serial_number: invoice.serial_number
        )
      end
    end
  end

  desc 'Move vehicle id to vehicle_invoices'
  task move_vehicle_id_invoice_id_to_vehicle_line_items: :environment do
    invoices = Invoice.where.not(vehicle_id: nil)
    puts "Going to move #{invoices.count} ids"
    values = invoices.map { |invoice| "(#{invoice.vehicle_id}, #{invoice.id}, #{invoice.total})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO invoices_vehicles (vehicle_id, invoice_id, total) VALUES #{values}")
    puts 'All done'
  end

  desc 'Move company id to join table company_invoice'
  task move_company_id_to_company_invoice: :environment do
    invoice = Invoice.all
    puts "Going to move #{invoice.count} ids"
    values = invoice.map { |invoice| "(#{invoice.company_id}, #{invoice.id})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO companies_invoices (company_id, invoice_id) VALUES #{values}")
    puts 'All done'
  end

  desc 'Change from column at_the_expense_of to general_expense'
  task change_from_at_the_expense_of_to_general_expense: :environment do
    invoices = Invoice.where(at_the_expense_of: 'general_expenses')
    puts "Going to value #{invoices.count} ids"
    invoices.each do |invoice|
      Invoice.transaction do
        if(invoice.at_the_expense_of == "general_expenses")
          invoice.update(general_expense: true)
        else
          invoice.update(general_expense: false)
        end
      end
    end
    puts 'All done'
  end

  desc 'Move items from taxable vat to line items table'
  task move_taxable_vat_to_line_items: :environment do
    invoices = Invoice.where(type_of_invoice: 'passiva');
    puts "Going to move #{invoices.count} line items"
    LineItem.transaction do
      invoices.each do |invoice|
        taxableVat = TaxableVatField.find_by(invoice_id: invoice.id)
        LineItem.create(
          vat: taxableVat.vat_rate,
          amount: taxableVat.taxable,
          invoice_id: taxableVat.invoice_id,
          description: invoice.description
        )
      end
    end
    puts 'All done'
  end

  desc 'Move items from taxable vat to sold line items table'
  task move_taxable_vat_to_sold_line_items: :environment do
    active_invoices = ActiveInvoice.all;
    puts "Going to move #{active_invoices.count} sold line items"
    SoldLineItem.transaction do
      active_invoices.each do |active_invoice|
        taxableVat = TaxableVatField.find_by(invoice_id: active_invoice.id)
        SoldLineItem.create(
          vat: taxableVat.vat_rate,
          amount: taxableVat.taxable,
          active_invoice_id: taxableVat.invoice_id,
          description: active_invoice.description
        )
      end
    end
    puts 'All done'
  end

  desc 'Remove all active invoices from invoices'
  task remove_active_invoices: :environment do
    active_invoices = ActiveInvoice.all;
    puts "Going to delete #{active_invoices.count} invoices"
    active_invoices.each do |active_invoice|
      Invoice.transaction do 
        invoice = Invoice.find(active_invoice.id)
        invoice.destroy()
      end
    end
    puts 'All done'
  end
end
