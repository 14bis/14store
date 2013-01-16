class CreateSpecificationCategories < ActiveRecord::Migration
  def up
    create_table :specification_categories do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
    SpecificationCategory.create_translation_table! :description => :string
  end
  def down
    drop_table :specification_categories
    SpecificationCategory.drop_translation_table!
  end
end
