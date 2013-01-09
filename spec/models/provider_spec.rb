require 'spec_helper'

describe Provider do
  before { @provider = Provider.new(name: "Provider 1", email: "provider1@provider1.com") }
  
  subject { @provider }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  it { should be_valid }
  
  describe "when name is not present should be invalid" do
    before { @provider.name = "  " }
    it { should_not be_valid }
  end
  
  describe "when name is too long should be invalid" do
    before { @provider.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present should be invalid" do
    before { @provider.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[provider@foo,com provider_at_foo.org example.provider@foo.]
      addresses.each do |invalid_address|
        @provider.email = invalid_address
        @provider.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[provider@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @provider.email = valid_address
        @provider.should be_valid
      end
    end
  end
  
end
