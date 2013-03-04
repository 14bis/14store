require 'spec_helper'

describe Spree::Order do
  before { @order = FactoryGirl.build(:order) }

  describe "deliver_order_confirmation_email_to_provider" do
    describe "when throws exceptions" do
      # before { Spree::OrderMailer.stub(:confirm_email_to_provider).and_raise(Exception) }
      it "handles them" do
        expect { @order.deliver_order_confirmation_email_to_provider }.to_not raise_error
      end
    end
  end
end