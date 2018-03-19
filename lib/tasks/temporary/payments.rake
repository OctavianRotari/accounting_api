namespace :payments do
  desc 'Move invoice id, payment id to invoices_payments'
  task move_ids_to_invoices_payments: :environment do
    payments = Payment.all
    puts "Going to move #{payments.count} ids"
    values = payments.map do |payment|
      invoice = Invoice.find(payment.invoice_id_identifier)
      table_name = 'invoices_payments'
      id_name = 'invoice_id'
      if(invoice.type_of_invoice == 'attiva')
        table_name = 'active_invoices_payments'
        id_name = 'active_invoice_id'
      end
      ActiveRecord::Base.connection.execute(
        "INSERT INTO #{table_name} (#{id_name}, payment_id) VALUES #{"(#{payment.invoice_id_identifier}, #{payment.id})"}"
      )
    end
    puts 'All done'
  end
end
