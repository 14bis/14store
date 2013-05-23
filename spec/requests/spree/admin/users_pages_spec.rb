require 'spec_helper'

describe "spree_admin_users_pages" do
  stub_authorization!
  let(:user) { FactoryGirl.create(:user) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }
  after(:all) do
    user.destroy
    user_provider.destroy
  end

  describe "create a new user" do
    before do
      visit spree.new_admin_user_path
      fill_in "user_email", with: "provider_user@provider.com"
      fill_in "Password", with: "123456"
      fill_in "Password Confirmation", with: "123456"
    end
    context "with provider role" do
      it "adds a new provider user" do
        fill_in "Name", with: "User"
        fill_in "Full Name", with: "Provider User"
        fill_in "Code", with: "P"
        fill_in "user_provider_attributes_email", with: "provider@provider.com"
        check("user_spree_role_provider")
        expect{click_button "Create"}.to change{Spree::User.includes("spree_roles").where(:spree_roles => {:id => Spree::Role.find_by_name("provider")}).count}.by(1)
      end
    end
    context "without provider role" do
      it "doesn't add a provider user" do
        expect{click_button "Create"}.to_not change{Spree::User.includes("spree_roles").where(:spree_roles => {:id => Spree::Role.find_by_name("provider")}).count}.by(1)
      end
      it "increase user count by 1" do
        expect{click_button "Create"}.to change{Spree::User.count}.by(1)
      end
    end
  end
  
  describe "edit a user" do
    describe "remove provider role" do
      before do
        visit spree.edit_admin_user_path user_provider
      end
      it "definir o que deve acontecer"
      #it "deletes the provider"
      #it "decrease the provider user count"
    end
    describe "add provider role" do
      before do
        visit spree.edit_admin_user_path user
        check("user_spree_role_provider")
        fill_in "Name", with: "User"
        fill_in "Full Name", with: "Provider User"
        fill_in "Code", with: "P"
        fill_in "user_provider_attributes_email", with: "provider@provider.com"
      end
      it "create a new provider" do
        expect{click_button "Update"}.to change{Provider.count}.by(1)
      end
      it "increase the provider user count" do
        expect{click_button "Update"}.to change{Spree::User.includes("spree_roles").where(:spree_roles => {:id => Spree::Role.find_by_name("provider")}).count}.by(1)
      end
    end
  end

end
