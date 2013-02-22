require "spec_helper"

describe "Home page" do

  context "with no products available to show" do
    it "displays the translated message for :no_products_found" do
      visit "/"
      page.should have_content( I18n.t('no_products_found') )
    end
  end

  context "with products available to show" do
    it "displays a products list" do
      FactoryGirl.create(:product)
      visit "/"
      page.should have_selector('ul#products')
    end

    it "displays the provider for each product" do
      products = [FactoryGirl.create(:product), FactoryGirl.create(:product)]
      visit "/"
      products.each do |product|
        within "#product_#{product.id}" do
          page.should have_content( product.provider.name )
        end
      end
    end

    it "must contain the trial class if a product have trial period" do
      product = FactoryGirl.create(:product)
      visit "/"
      within "#products" do
        if product.have_trial_period?
          page.should have_selector( "li.trial" )
        end
      end
    end

  end

end
