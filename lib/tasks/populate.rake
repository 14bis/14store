namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    
    [Provider, Spree::Product, Specification, SpecificationCategory].each(&:delete_all)
    
    @provider = Provider.create!(name: Faker::Company.name,
                                 email: Faker::Internet.email)
                     
    50.times do |n|
      name  = "Product-#{n+1}"
      price = rand
      available_on = 2.days.ago..Time.now
      provider_id = @provider.id
      Spree::Product.create!(name: name,
                             price: price,
                             available_on: available_on,
                             provider_id: provider_id)
    end
    
    os = SpecificationCategory.create(code: "OS", description: "Operational System")
    Specification.create(specification_category_id: os.id, description: "Ubuntu x32")
    Specification.create(specification_category_id: os.id, description: "Ubuntu x64")
    
    ram = SpecificationCategory.create(code: "RAM", description: "Random Access Memory")
    Specification.create(specification_category_id: ram.id, description: "2GB")
    Specification.create(specification_category_id: ram.id, description: "4GB")
    Specification.create(specification_category_id: ram.id, description: "6GB")
    Specification.create(specification_category_id: ram.id, description: "8GB")
    
    SpecificationCategory.create(code: "HD", description: "Hard Disk")
  end
end
