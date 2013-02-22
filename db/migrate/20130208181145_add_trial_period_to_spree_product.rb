class AddTrialPeriodToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :trial_period, :integer
  end
end
