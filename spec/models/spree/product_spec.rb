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
  it { should respond_to(:trial_period)}
  it { should respond_to(:publication_requests) }
  
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

    context "with status :approved" do
      it "is invalid if avilable_on is not set" do
        @product.status = Spree::Product::APPROVED
        @product.available_on = nil
        should_not be_valid
      end
      it "is valid if avilable_on is set" do
        @product.status = Spree::Product::APPROVED
        @product.available_on = Time.now
        should be_valid
      end
    end

    context "with available_on set" do
      it "is invalid if status is not :approved" do
        @product.available_on = Time.now
        Spree::Product::STATUSES.reject {|key, value| key == Spree::Product::APPROVED}.each_key do |status|
          @product.status = status
          should_not be_valid
        end
      end
    end
  end
end
