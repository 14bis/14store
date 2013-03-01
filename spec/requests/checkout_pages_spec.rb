require "spec_helper"

describe "Checkout proccess starting from product#show" do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  before do 
    Spree::Order.any_instance.stub(:user).and_return(user)
    visit spree.product_path product
  end

  it "displays trial period message" do
    page.should have_content( product.trial_message )
  end
  describe "after purchase" do
    before { click_button "Purchase" }
    it "places an order and send emails" do
      click_button "Place Order"
      ActionMailer::Base.deliveries.should_not be_empty
      page.should have_content("Order")
    end
    it "displays trial period full message" do
      page.should have_content( product.trial_full_message )
    end
  end

end
