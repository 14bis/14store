require 'ffaker'

FactoryGirl.define do

  factory :user, class: Spree::User do
    email                 "user@spree.com"
    password              "password"
    password_confirmation "password"
    ignore do
      role "user"
    end
    factory :admin do
      ignore do
        role "admin"
      end
    end
    factory :user_provider do
      ignore do
        role "provider"
      end
    end

    after(:create) do |user, evaluator|
      if evaluator.role == "admin"
         user.spree_roles = [ROLE_ADMIN]
      elsif evaluator.role == "provider"
        user.provider = FactoryGirl.create(:provider)
        user.spree_roles = [ROLE_PROVIDER]
      else
        user.spree_roles = [ROLE_USER]
      end
    end
  end

  factory :provider do
    name     { Faker::Company.name }
    email    { Faker::Internet.email }
  end
  factory :invalid_provider, parent: :contact do
    name nil
  end

  factory :product, class: Spree::Product do
    name          "Product 1"
    price         { rand }
    trial_period  14
    available_on  { 2.days.ago..Time.now }
    status        Spree::Product::APPROVED
    provider
  end

  factory :specification_category do
    code          "TES"
    description   "This is a testing specification category"
  end

  factory :specification do
    specification_category
    description { Faker::Lorem.sentence }
  end

  factory :requirement do
    specification
    product
  end

end
