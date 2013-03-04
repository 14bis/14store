require 'spec_helper'

describe "Management namespace" do

  describe "for non-logged-in users" do  
  
    let(:user_provider) { FactoryGirl.create(:user_provider) }
    let(:user) { FactoryGirl.create(:user) }  
    after(:all) do 
      user.destroy 
      user_provider.destroy
    end
    
    describe "when attempting to visit the protect area" do
      it "redirects to login" do
        visit management_path
        current_path.should == "/login"
      end
      describe "after login as a user that has the spree_role :provider" do
        before do
          stub_management_login! user_provider
          visit management_path
        end
        
        it "should render the desired protected page" do
          # page.should have_selector('title', text: 'Products')
          page.should have_content('Products')
        end
        it "should allow the user to logout" do
          click_link "Logout"
          page.should have_content "Login"
        end
      end
      
      describe "after login as a user that doesn't have the spree_role :provider" do
        before do
          stub_management_login! user
          visit management_path
        end
        it "should render the home page" do
          page.should have_selector('li#home-link')
        end
      end
      
    end
  end
  
  describe "index" do
    stub_authorize!
    before do
      visit management_path 
    end
    it "should have a link to products" do
      page.find_link("Products")['/management/products']
    end
  
  end

end
