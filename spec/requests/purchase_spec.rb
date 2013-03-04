require "spec_helper"

describe "Purchase" do
  before { Spree::Order.any_instance.stub(:user).and_return( FactoryGirl.create(:user) ) }
  let(:product) { FactoryGirl.create(:product_approved) }
  let(:product_trial) { FactoryGirl.create(:product_approved, :trial_period => 1) }
  context "a trial product" do
    before do
      visit spree.product_path product_trial
      click_button "Purchase"
    end
    it "displays trial period full message" do
      page.should have_content( product_trial.trial_full_message )
    end
    it "doesn't display the payment state" do
      page.should_not have_selector "#checkout-step-payment"
    end
    it "doesn't include more than one product" do
      visit spree.product_path product_trial
      click_button "Purchase"
      within "#order-total" do page.should have_content product_trial.display_amount end
    end
    context "when places an order" do
      it "sends emails" do
        click_button "Place Order"
        ActionMailer::Base.deliveries.should_not be_empty
      end
    end
  end
  context "a non-trial product" do
    before do
      visit spree.product_path product
      click_button "Purchase"
    end
    it "displays the payment state" do
      page.should have_selector "#checkout-step-payment"
    end
    it "doesn't include more than one product" do
      visit spree.product_path product
      click_button "Purchase"
      within "#summary-order-total" do page.should have_content product.display_amount end
    end
  end
end
