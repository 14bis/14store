require 'ffaker'

FactoryGirl.define do

  factory :user, class: Spree::User do
    email                 "user@spree.com"
    password              "password"
    password_confirmation "password"
    ignore do
      admin false
    end
    factory :admin do
      ignore do
        admin true
      end
    end

    after(:create) do |user, evaluator|
      # Somehow, the admin role is added by default
      if evaluator.admin
        user.spree_roles << FactoryGirl.create(:role_user)
      else
        user.spree_roles = [FactoryGirl.create(:role_user)]
      end
    end
  end

  factory :role_user, class: Spree::Role do
    name "user"
  end
#  factory :role_admin, class: Spree::Role do
#    name "admin"
#  end

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
