require 'ffaker'

FactoryGirl.define do

  factory :user, class: Spree::User do
    email                 "user@spree.com"
    password              "password"
    password_confirmation "password"
    spree_roles           { [Spree::Role.find_by_name("user")] }
    factory :admin do
      email               "admin@spree.com"
      spree_roles         { [Spree::Role.find_by_name("admin")] }
    end
    factory :user_provider do
      email               "provider@spree.com"
      spree_roles         { [Spree::Role.find_by_name("provider")] }
      provider
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
    trial_period  0
    provider
    factory :product_approved do
      available_on  { 2.days.ago..Time.now }
      status        Spree::Product::APPROVED
    end
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

  factory :order, class: Spree::Order do
    user
  end

  factory :publication_request do
    status { PublicationRequest::OPEN }
    product
  end

end
