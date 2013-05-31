class DropTranslationTablesForSpreeClasses < ActiveRecord::Migration
  def up
    Spree::Product.drop_translation_table!
    Spree::Taxon.drop_translation_table!
    Spree::Taxonomy.drop_translation_table!
  end

  def down
    Spree::Product.create_translation_table!({
      :name=> :string,
      :description => :text,
      :meta_description => :text,
      :meta_keywords => :string
    }, {
      :migrate_data => true
    })

    Spree::Taxon.create_translation_table!({
      :name=> :string,
      :description => :text
    }, {
      :migrate_data => true
    })

    Spree::Taxonomy.create_translation_table!({
      :name=> :string
    }, {
      :migrate_data => true
    })
  end
end
