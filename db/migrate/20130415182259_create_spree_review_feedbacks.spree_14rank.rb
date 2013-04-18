# This migration comes from spree_14rank (originally 20130403142426)
class CreateSpreeReviewFeedbacks < ActiveRecord::Migration
  def change
    create_table :spree_review_feedbacks do |t|
      t.integer :user_id
      t.integer :review_id, :null => false
      t.integer :rating, :default => 0
      t.text :comment
      t.timestamps
    end
    add_index :spree_review_feedbacks, :review_id
    add_index :spree_review_feedbacks, :user_id
  end
end
