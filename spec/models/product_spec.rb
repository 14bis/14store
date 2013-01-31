require 'spec_helper'

describe Spree::Product do
  before { @product = FactoryGirl.create(:product) }
  
  subject { @product }

  it { should respond_to(:name) }
  it { should respond_to(:price) }  
  it { should respond_to(:description) }
  it { should respond_to(:provider) }
  it { should respond_to(:provider_id) }
  it { should respond_to(:requirements) }
  
  describe "during validation" do
    it "has a valid factory" do
      should be_valid
    end
    
    it "is invalid without a provider" do
      @product.provider = nil
      should_not be_valid
    end
    
    it "is invalid without a name" do
      @product.name = "  "
      should_not be_valid
    end
    
    it "is invalid without a price" do
      @product.price = nil
      should_not be_valid
    end
    
  end
  
end
