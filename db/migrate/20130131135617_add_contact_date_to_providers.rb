class AddContactDateToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :phone1, :string
    add_column :providers, :phone2, :string
    add_column :providers, :fax, :string
    add_column :providers, :address1, :string
    add_column :providers, :address2, :string
    add_column :providers, :city, :string
    add_column :providers, :zipcode, :string
    add_column :providers, :state_id, :integer
    add_column :providers, :country_id, :integer
  end
end
