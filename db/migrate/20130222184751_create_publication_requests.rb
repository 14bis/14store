class CreatePublicationRequests < ActiveRecord::Migration
  def change
    create_table :publication_requests do |t|
      t.integer :product_id
      t.integer :status

      t.timestamps
    end
  end
end
