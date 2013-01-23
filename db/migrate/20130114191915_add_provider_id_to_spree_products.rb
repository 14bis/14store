class AddProviderIdToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :provider_id, :integer
  end
end
