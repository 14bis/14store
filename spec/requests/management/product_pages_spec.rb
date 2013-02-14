require "spec_helper"

describe "Management products" do
  stub_authorize!
  
  before do
    visit management_products_path
  end
  
  describe "index" do
    
    describe "when has no owner products to show" do
      it { page.should have_content "No products found" }
    end
    
    describe "when has owner products to show" do
      it "displays the list"
    end
  
  end  
end
