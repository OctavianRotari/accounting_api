namespace :invoices do
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
  task move_vehicle_id_to_vehicle_line_items: :environment do
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

  desc 'Change from column at_the_expense_of to general_expence'
  task change_from_at_the_expense_of_to_general_expence: :environment do
    invoices = Invoice.where(at_the_expense_of: 'general_expenses')
    puts "Going to value #{invoices.count} ids"
    Invoice.transaction do
      invoices.each do |invoice|
        if(invoice.at_the_expense_of == "Spese generali")
          invoice.general_expence = true
        else
          invoice.general_expence = false
        end
      end
    end
    puts 'All done'
  end

  desc 'Remove all active invoices from invoices'
  task remove_active_invoices: :environment do
    invoices = Invoice.where(type_of_invoice: 'attiva')
    puts "Going to delete #{invoices.count} invoices"
    invoices.destroy_all()
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
          description: invoice.reason
        )
      end
    end
    puts 'All done'
  end

  desc 'Move items from taxable vat to sold line items table'
  task move_taxable_vat_to_sold_line_items: :environment do
    invoices = Invoice.where(type_of_invoice: 'attiva');
    puts "Going to move #{invoices.count} sold line items"
    SoldLineItem.transaction do
      invoices.each do |invoice|
        taxableVat = TaxableVatField.find_by(invoice_id: invoice.id)
        SoldLineItem.create(
          vat: taxableVat.vat_rate,
          amount: taxableVat.taxable,
          invoice_id: taxableVat.invoice_id,
          description: invoice.reason
        )
      end
    end
    puts 'All done'
  end
end
