require "spec_helper"

describe "Product Page" do

  it "displays the trial product message if available" do
    product = FactoryGirl.create(:product)
    visit "/products/product-#{product.id}"
    save_and_open_page
    within "#product-description" do
      if product.have_trial_period?
        page.should have_content( product.trial_message )
      end
    end
  end
end