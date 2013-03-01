require "spec_helper"

describe "Store Product Pages" do

  describe "show" do
    context "with trial period" do
      let(:product_with_trial) { FactoryGirl.create(:product, :trial_period => 1) }
      before { visit spree.product_path product_with_trial }
      it "has trial css class" do
        page.should have_selector (".trial")
      end
      it "displays the trial product message" do
        page.should have_content( product_with_trial.trial_message )
      end
    end
    context "without trial period" do
      it "doesn't have trial css class" do
        product = FactoryGirl.create(:product, :trial_period => 0)
        visit spree.product_path product
        page.should_not have_selector (".trial")
      end
    end
  end
end