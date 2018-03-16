namespace :insurances do
  desc 'Move vehicle id, ticket id to tickets_vehicles'
  task move_vehicle_id_to_insurances_vehicles: :environment do
    insurances = Insurance.where(at_the_expense_of: 'specific_vehicle')
    puts "Going to move #{insurances.count} ids"
    values = insurances.map {|insurance| "(#{insurance.vehicle_id}, #{insurance.id})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO insurances_vehicles (vehicle_id, insurance_id) VALUES #{values}")
  end

  desc 'Move company id to join table companies_insurances'
  task move_company_id_to_insurances_companies: :environment do
    insurances = Insurance.all
    puts "Going to move #{insurances.count} ids"
    values = insurances.map { |insurance| "(#{insurance.id}, #{insurance.company_id})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO insurances_companies (insurance_id, company_id) VALUES #{values}")
    puts 'All done'
  end

end
