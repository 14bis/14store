require 'spec_helper'

describe SpecificationCategory do

  before { @sc = SpecificationCategory.new(code: "T", description: "Test") }

  subject { @sc }
  
  it { should respond_to(:code) }
  it { should respond_to(:description) }
  
  describe "when code is not present" do
    before { @sc.code = "  " }
    it { should_not be_valid }
  end
  
  describe "when code is already taken" do
    before do
      sc_with_same_code = @sc.dup
      sc_with_same_code.code = @sc.code.downcase
      sc_with_same_code.save!
    end

    it { should_not be_valid }
  end
  
  describe "when description is not present" do
    before { @sc.description = "  " }
    it { should_not be_valid }
  end
    
end
