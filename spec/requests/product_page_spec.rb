require "spec_helper"

describe "Product Page" do

  it "displays the trial product message if available" do
    product = FactoryGirl.create(:product)
    visit "/products/product-#{product.id}"
    within "#product-description" do
        page.should have_content( product.trial_message )
    end
  end
end