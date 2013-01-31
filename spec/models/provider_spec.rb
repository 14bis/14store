require 'spec_helper'

describe Provider do
  before { @provider = FactoryGirl.build(:provider) }
  
  subject { @provider }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  describe "during validation" do
    it "has a valid factory" do
      should be_valid
    end
    
    it "is invalid when name is not present" do
      @provider.name = "  "
      should_not be_valid
    end
    
    it "is invalid when name is too long" do
      @provider.name = "a" * 51
      should_not be_valid
    end

    it "is invalid when email is not present" do
      @provider.email = " "
      should_not be_valid
    end
    
    it "is invalid when email format is invalid" do
      addresses = %w[provider@foo,com provider_at_foo.org example.provider@foo.]
      addresses.each do |invalid_address|
        @provider.email = invalid_address
        should_not be_valid
      end
    end

    it "is valid when email format is valid" do
      addresses = %w[provider@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @provider.email = valid_address
        should be_valid
      end
    end
  end
  
end
