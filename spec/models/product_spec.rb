require 'spec_helper'

describe Spree::Product do
  before do
    @provider = Provider.new(name: "Provider 1", email: "provider1@provider1.com")
    @product = Spree::Product.new(name: "Product 1", price: 1, provider_id: @provider.id)
  
  end
  
  subject { @product }
  
  it { should respond_to(:provider) }
  
end
