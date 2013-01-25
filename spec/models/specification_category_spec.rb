require 'spec_helper'

describe SpecificationCategory do

  before { @sc = FactoryGirl.build(:specification_category) }

  subject { @sc }
  
  it { should respond_to(:code) }
  it { should respond_to(:description) }
  
  describe "during validation" do
    it "has a valid factory" do
      should be_valid
    end
    it "is invalid when code is blank" do
      @sc.code = "   "
      should_not be_valid
    end
    
    it "is invalid when code is already taken" do
      sc_with_same_code = @sc.dup
      sc_with_same_code.code = @sc.code.downcase
      sc_with_same_code.save!
      should_not be_valid
    end
    
    it "is invalid when description is blank" do
      @sc.description = "  "
      should_not be_valid
    end
  end
  
end
