require 'spec_helper'

describe Spree::User do
  
  describe "during validation" do
    context "without admin role" do
      it "has a valid factory" do
        @user = FactoryGirl.create(:user)
        @user.spree_roles.map{ |r| r.name }.should eq %w(user)
      end
    end
    context "with admin role" do
      it "has a valid admin factory" do
        @admin = FactoryGirl.create(:admin)
        @admin.spree_roles.map{ |r| r.name }.should eq %w(admin user)
      end
    end
    
  end
end
