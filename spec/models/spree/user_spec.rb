require 'spec_helper'

describe Spree::User do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }
  after(:all) do 
    user.destroy
    admin.destroy
    user_provider.destroy
  end
  
  context "with user role" do
    it "has a valid factory" do
      user.spree_roles.map{ |r| r.name }.should eq %w(user)
    end
  end
  
  context "with admin role" do
    it "has a valid factory" do
      admin.spree_roles.map{ |r| r.name }.should eq %w(admin)
      admin.provider.should be_nil
    end
  end
  
  context "with provider role" do
    it "has a valid factory" do
      user_provider.spree_roles.map{ |r| r.name }.should == ["provider"]
      user_provider.provider.should_not be_nil
    end
    # it "is invalid withoud a provider" do
    #   user_provider.provider = nil
    #   user_provider.should_not be_valid
    # end
  end
  
  # context "without provider role" do
  #   it "is invalid with a provider" do
  #     user = FactoryGirl.create(:user)
  #     user.provider = FactoryGirl.create(:provider)
  #     user.should_not be_valid
  #   end
  # end
    
end
