class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :value
      t.integer :product_id
      t.references :specification

      t.timestamps
    end
    add_index :requirements, :product_id
    add_index :requirements, :specification_id
  end
end
