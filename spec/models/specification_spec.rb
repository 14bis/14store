require 'spec_helper'

describe Specification do

  before { @specification = Specification.new(description: "Specification 1") }
  
  subject { @specification }
  
  it { should respond_to(:description) }
  it { should respond_to(:specification_category_id) }
  it { should respond_to(:specification_category) }

  describe "when specification_category is not present" do
    before { @specification.specification_category = nil }
    it { should_not be_valid }
  end

end
