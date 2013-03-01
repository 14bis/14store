require "spec_helper"

describe "Checkout proccess" do

  context "with a logged user" do
    before { login FactoryGirl.create(:user) }
    it "checks out and send emails" do
      product = FactoryGirl.create(:product)
      visit "/"
      click_link product.name
      click_button "add-to-cart-button"
      click_button "Checkout"
      click_button "Place Order"
      ActionMailer::Base.deliveries.should_not be_empty
      page.should have_content("Order")
    end

    it "displays trial period message if available" do
      product = FactoryGirl.create(:product)
      visit "/"
      click_link product.name
      click_button "add-to-cart-button"
      click_button "Checkout"
      page.should have_content( product.trial_full_message )
    end
  end

end