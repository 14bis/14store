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



    [Provider, Spree::Product, Specification, SpecificationCategory].each(&:delete_all)

    @provider = Provider.create!(name: Faker::Company.name,
                                 email: Faker::Internet.email)

    25.times do |n|
      name  = "Product-#{n+1}"
      price = rand
      available_on = 2.days.ago..Time.now
      provider_id = @provider.id
      trial_number = rand( 85 )
      if trial_number % 7 == 0 || trial_number == 0
        trial_period = trial_number
      else
        trial_period = 0
      end
      Spree::Product.create!(name: name,
                             price: price,
                             available_on: available_on,
                             provider_id: provider_id,
                             trial_period: trial_period)
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
