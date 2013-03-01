require 'spec_helper'

describe "spree_admin_providers_pages" do

  let(:user) { FactoryGirl.create(:admin) }
  after(:all) { user.destroy }

  describe "edit" do
    
    let(:provider) { FactoryGirl.create(:provider) }
    after(:all) { provider.destroy }
    before do
      login user
      visit spree.edit_admin_provider_path(provider)
    end
  
    describe "page" do
      
      it "has all editable fields" do
        page.should have_selector('label',    text: "Name")
        page.should have_selector('label',    text: "Email")
        page.should have_selector('label',    text: "Phone1")
        page.should have_selector('label',    text: "Phone2")
        page.should have_selector('label',    text: "Address1")
        page.should have_selector('label',    text: "Address2")
        page.should have_selector('label',    text: "Fax")
        page.should have_selector('label',    text: "City")
        page.should have_selector('label',    text: "State")
        page.should have_selector('label',    text: "Country")
        page.should have_selector('label',    text: "Website")
        page.should have_selector('label',    text: "Code")
        page.should have_selector('label',    text: "Full Name")
      end
    end
      
    context "with invalid information" do
      it "shows a selector for an error message" do
        page.should_not have_selector('.field_with_errors')
        fill_in "Name", with: ""
        click_button "Update" 
        page.should have_selector('.field_with_errors')
      end
    end
    
    context "with valid information" do
      let(:new_name) { "New Name" }
      before do
        fill_in "Name", with: new_name
        click_button "Update"
      end
      
      it "updates the name" do provider.reload.name.should == new_name end
      
    end
  
  end

 
end
