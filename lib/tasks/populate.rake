namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    
    [Provider, Spree::Product, Specification].each(&:delete_all)
    
    @provider = Provider.create!(name: Faker::Company.name,
                                 email: Faker::Internet.email)
                     
    3.times do |n|
      name  = "Product-#{n+1}"
      price = rand
      available_on = 2.days.ago..Time.now
      provider_id = @provider.id
      Spree::Product.create!(name: name,
                             price: price,
                             available_on: available_on,
                             provider_id: provider_id)
    end
    
  end
end
