# encoding: UTF-8

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    
    brazil = Spree::Country.find_by_iso('BR')
    brazil.states.find_or_create_by_abbr_and_name('AL','Alagoas')
    brazil.states.find_or_create_by_abbr_and_name('BA','Bahia')
    brazil.states.find_or_create_by_abbr_and_name('CE','Ceará')
    brazil.states.find_or_create_by_abbr_and_name('MA','Maranhão')
    brazil.states.find_or_create_by_abbr_and_name('PB','Paraíba')
    brazil.states.find_or_create_by_abbr_and_name('PE','Pernambuco')
    brazil.states.find_or_create_by_abbr_and_name('PI','Piauí')
    brazil.states.find_or_create_by_abbr_and_name('RN','Rio Grande do Norte')
    brazil.states.find_or_create_by_abbr_and_name('SE','Sergipe')
    
    
    
    [Provider, Spree::Product, Specification].each(&:delete_all)
    @users = Spree::User.where("id > ?", 1)
    @users.each(&:destroy)
    
    os = SpecificationCategory.find_by_code("OS")
    Specification.create(specification_category_id: os.id, description: "Ubuntu x32")
    Specification.create(specification_category_id: os.id, description: "Ubuntu x64")
    
    ram = SpecificationCategory.find_by_code("RAM")
    Specification.create(specification_category_id: ram.id, description: "2GB")
    Specification.create(specification_category_id: ram.id, description: "4GB")
    Specification.create(specification_category_id: ram.id, description: "6GB")
    Specification.create(specification_category_id: ram.id, description: "8GB")
    
    @user_provider = Spree::User.new(email: "provider@provider.com", password: "123456", password_confirmation: "123456")
    @user_provider.spree_roles << Spree::Role.find_by_name("provider")
    @user_provider.provider = Provider.new(name: Faker::Company.name,
                                 email: Faker::Internet.email)
    @user_provider.save!
                     
    25.times do |n|
      name  = "Product-#{n+1}"
      price = rand
      available_on = 2.days.ago..Time.now
      provider_id = @user_provider.provider.id
      Spree::Product.create!(name: name,
                             price: price,
                             available_on: available_on,
                             provider_id: provider_id)
    end
    
  end
end
