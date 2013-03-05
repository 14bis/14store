require "spec_helper"

describe "management_products_pages" do

  before(:all) { @user_provider = FactoryGirl.create(:user_provider) }
  after(:all) do 
    @user_provider.provider.destroy 
    @user_provider.destroy 
  end
  before { stub_login @user_provider }
  let(:new_name) { "New product name" }
  let(:my_product) { FactoryGirl.create(:product, :provider => @user_provider.provider, :name => "My Product") }
      
  describe "index" do
    describe "when has no owner products to show" do
      before do
        FactoryGirl.create(:product)
        visit management_products_path
      end
      
      it { page.should have_content "No products found" }
    end
    
    describe "when has owner products to show" do
      before do
        my_product
        FactoryGirl.create(:product, :name => "Other Product")
        visit management_products_path
      end
      it "displays the products" do
        page.should have_content "My Product"
        page.should_not have_content "Other Product"
      end
      it "submits a product for approval" do
        within "#product_#{my_product.id}" do
          click_link 'Submit For Aproval'
        end
        within "#product_#{my_product.id}" do
          page.should have_content "Submitted"
        end
      end
    end
  end
    
  describe "edit" do
    before do
      visit edit_management_product_path my_product
    end
    describe "page" do
      it { page.should_not have_selector "#product_available_on" }
    end
    context "with valid attributes" do
      it "updates the name" do 
        fill_in "Name", with: new_name
        click_button "Update"
        my_product.reload.name.should == new_name 
      end
    end
    
    context "with invalid attributes" do
      it "doesn't update the name" do
        fill_in "Name", with: ""
        click_button "Update"
        my_product.reload.name.should_not == ""
      end
    end
  end
  
end
