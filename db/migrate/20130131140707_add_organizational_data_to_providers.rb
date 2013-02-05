class AddOrganizationalDataToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :full_name, :string
    add_column :providers, :website, :string
    add_column :providers, :code, :string
  end
end
