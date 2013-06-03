require "spec_helper"

describe "Home page" do
  context "with a logged user" do
    it "shows link for user's account" do
      login FactoryGirl.create(:user)
      page.should have_selector('a', :text => "My Account")
    end
    context "as provider" do
      it "shows links for user's account and provider administration" do
        login FactoryGirl.create(:user_provider)
        page.should have_selector('a', :text => "My Account")
        page.should have_content( 'Administration')
      end
    end
    context "as admin" do
      it "shows links for user's account and store administration" do
        login FactoryGirl.create(:admin)
        page.should have_selector('a', :text => "Administration")
      end
    end
  end

  context "with no products available to show" do
    it "displays 'No Products Found'" do
      visit "/"
      page.should have_content( 'No products found' )
    end
  end

  context "with products available to show" do
    it "displays a products list" do
      FactoryGirl.create(:product_approved)
      visit "/"
      page.should have_selector('ul#products')
    end

    it "displays a link for the provider of each product" do
      products = [FactoryGirl.create(:product_approved), FactoryGirl.create(:product_approved)]
      visit "/"
      products.each do |product|
        within "#product_#{product.id}" do
          provider = product.provider
          page.should have_link( "#{provider.name}", href: spree.provider_path(provider) )
        end
      end
    end

    it "should contain the trial class only if a product have trial period" do
      product_with_trial = FactoryGirl.create(:product_approved, :trial_period => 1)
      product_without_trial = FactoryGirl.create(:product_approved, :trial_period => 0)
      visit "/"
      page.should have_selector( "#product_#{product_with_trial.id}.trial" )
      page.should_not have_selector( "#product_#{product_without_trial.id}.trial" )
    end
  end

end
