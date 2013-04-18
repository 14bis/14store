# This migration comes from spree_14rank (originally 20130402133813)
class AddAvgRatingToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :avg_rating, :float
  end
end
