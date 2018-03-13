namespace :users do 
  desc 'Adds user provider and uid'
  task set_provider_uid: :environment do
    users = User.all
    puts "Going to update #{users.count} users"
    User.transaction do
      users.each do |user|
        user.provider = 'email'
        user.uid = user.email
        print '.'
      end
    end
    puts "All done!"
  end
end

