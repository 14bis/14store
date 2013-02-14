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
      if product.trial_period > 0
        click_button "Place Order"
      end
      ActionMailer::Base.deliveries.should_not be_empty
      page.should have_content("Order")
    end
  end

end
