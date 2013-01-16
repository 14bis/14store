class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.string :description
      t.integer :specification_category_id
      
      t.timestamps
    end
  end
end
