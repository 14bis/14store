require "spec_helper"

describe "Management products" do

  before(:all) { @user_provider = FactoryGirl.create(:user_provider) }
  after(:all) { @user_provider.destroy }
  before { stub_login! @user_provider }
      
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
        FactoryGirl.create(:product, :provider => @user_provider.provider, :name => "Test1")
        FactoryGirl.create(:product, :provider => @user_provider.provider, :name => "Test2")
        FactoryGirl.create(:product, :name => "Test3")
        visit management_products_path
      end
      it "displays the products" do
        page.should have_content "Test1"
        page.should have_content "Test2"
        page.should_not have_content "Test3"
      end
    end
  end
    
  
  let(:new_name) { "New product name" }
  let(:my_product) { FactoryGirl.create(:product, :provider => @user_provider.provider) }
  after(:all) { my_product.destroy }  
  describe "edit" do
    before do
      visit edit_management_product_path my_product
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
