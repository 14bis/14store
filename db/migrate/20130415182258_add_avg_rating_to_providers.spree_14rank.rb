# This migration comes from spree_14rank (originally 20130402133814)
class AddAvgRatingToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :avg_rating, :float
  end
end