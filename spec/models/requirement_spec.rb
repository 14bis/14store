require 'spec_helper'

describe Requirement do

  before do
    @requirement = FactoryGirl.build(:requirement)
  end
  
  subject { @requirement }  

  it { should respond_to(:value) }
  it { should respond_to(:product) }
  it { should respond_to(:specification) }
  
  describe "during validation" do
    it "has a valid factory" do 
      @requirement.should be_valid
    end  
    
    it "is invalid without a product" do
      @requirement.product = nil
      @requirement.should_not be_valid
    end
    
    it "is invalid without a specification" do
      @requirement.specification = nil
      @requirement.should_not be_valid
    end
  end
  
  describe "accessible attributes" do
    it "should not allow access to product_id" do
      expect do
        Requirement.new(product: FactoryGirl.build(:product).id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should not allow access to specification_id" do
      expect do
        Requirement.new(specification: @requirement.specification.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end
