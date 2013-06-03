require 'spec_helper'

describe Specification do

  before { @specification = FactoryGirl.build(:specification) }
  
  subject { @specification }
  
  it { should respond_to(:description) }
  it { should respond_to(:specification_category_id) }
  it { should respond_to(:specification_category) }

  describe "during validation" do
    it "has a valid factory" do
      should be_valid
    end
    it "is invalid when specification_category is not present" do
      @specification.specification_category = nil
      should_not be_valid
    end
  end

end
