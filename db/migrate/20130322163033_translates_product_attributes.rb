class TranslatesProductAttributes < ActiveRecord::Migration
  def up
    Spree::Product.create_translation_table!({
      :name=> :string,
      :description => :text,
      :meta_description => :text,
      :meta_keywords => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Spree::Product.drop_translation_table! :migrate_data => true
  end
end
