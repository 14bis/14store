require 'spec_helper'

describe "Management namespace" do

  describe "for non-logged-in users" do  
  
    let(:user_provider) { FactoryGirl.create(:user_provider) }
    let(:user) { FactoryGirl.create(:user) }  
    after(:all) do 
      user.destroy 
      user_provider.destroy
    end
    
    before do
      visit management_path 
    end
    
    describe "when attempting to visit the protect area" do
      
      describe "after login as a user that has the spree_role :provider" do
        before do
          fill_in "Email", with: user_provider.email
          fill_in "Password", with: user_provider.password
          click_button "Login"
        end
        it "should render the desired protected page" do
          # page.should have_selector('title', text: 'Products')
          page.should have_content('Products')
        end
      end
      
      describe "after login as a user that doesn't have the spree_role :provider" do
        before do
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Login"
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
      save_and_open_page
      page.find_link("Products")['/management/products']
    end
  
  end

end
