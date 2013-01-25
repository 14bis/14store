require "spec_helper"

describe "Home page" do

  subject { page }

  context "with no products available to show" do
    it "displays the translated message for :no_products_found" do
      visit "/"
      should have_content( I18n.t('no_products_found') )
    end
  end
  
  context "with products available to show" do
    it "displays a products list" do
      FactoryGirl.create(:product)
      visit "/"
      should have_selector('ul#products')
    end
  end

end
