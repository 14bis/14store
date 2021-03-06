# encoding: UTF-8

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    I18n.locale = 'pt-BR'

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
      trial_number = rand( 85 )
      if trial_number % 7 == 0 || trial_number == 0
        trial_period = trial_number
      else
        trial_period = 0
      end

      p = Spree::Product.new(name: name,
                             price: price,
                             available_on: available_on,
                             trial_period: trial_period,
                             provider_id: provider_id)
      p.status = Spree::Product::APPROVED
      p.save!
    end

  end
end
