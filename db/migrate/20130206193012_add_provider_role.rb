class AddProviderRole < ActiveRecord::Migration
  def up
    Spree::Role.create :name => "provider"
  end

  def down
    Spree::Role.delete_all
  end
end
