# This migration comes from spree_14rank (originally 20130328132544)
class CreateSpreeReviews < ActiveRecord::Migration
  def change
    create_table :spree_reviews do |t|
      t.integer :user_id
      t.integer :rating
      t.string :location
      t.string :title
      t.text :comment
      t.timestamps
      t.string :type
      t.integer :product_id
      t.integer :provider_id
    end
    add_index :spree_reviews, :provider_id
    add_index :spree_reviews, :product_id
    add_index :spree_reviews, :user_id
  end
end
