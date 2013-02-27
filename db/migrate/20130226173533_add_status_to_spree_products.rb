class AddStatusToSpreeProducts < ActiveRecord::Migration
  def change
  	add_column :spree_products, :status, :integer, :default => 0
  end
end
