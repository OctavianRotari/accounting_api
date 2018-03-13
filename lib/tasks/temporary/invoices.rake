namespace :invoices do
  desc 'Move all passive invoices into receipts'
  task move_active_invoice_to_receipts: :environment do
    invoices = Invoice.where(type_of_invoice: 'attiva')
    puts "Going to update #{invoices.count} invoices"
    Receipt.transaction do
      invoices.each do |invoice|
        Receipt.create(
          id: invoice.id,
          date_of_issue: invoice.date_of_issue,
          deadline: invoice.deadline,
          collected: invoice.paid,
          serial_number: invoice.serial_number
        )
      end
    end
  end

  desc 'Move vehicle id to vehicle_line_items'
  task move_vehicle_id_to_vehicle_line_items: :environment do
    invoices = Invoice.where.not(vehicle_id: nil)
    puts "Going to move #{invoices.count} ids"
    VehicleLineItem.transaction do
      invoices.each do |invoice|
        VehicleLineItem.create(
          invoice_id: invoice.id,
          total: invoice.total,
          vehicle_id: invoice.vehicle_id,
        )
      end
    end
  end

  desc 'Move vehicle id to join table vehicle_invoice'
  task move_company_id_to_company_invoice: :environment do
    invoice = Invoice.all
    puts "Going to move #{invoice.count} ids"
    values = invoice.map { |invoice| "(#{invoice.company_id}, #{invoice.id})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO companies_invoices (company_id, invoice_id) VALUES #{values}")
  end

  desc 'Remove all passive invoices from invoices'
  task remove_passive_invoices: :environment do
    invoices = Invoice.where(type_of_invoice: 'passiva')
    puts "Going to delete #{invoices.count} invoices"
    Invoice.transaction do
      invoices.each do |invoice|
        Invoice.delete(id: invoice.id)
      end
    end
    puts 'All done'
  end
end
