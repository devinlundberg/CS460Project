class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :client
      t.string :requestedBy
      t.decimal :price
      t.string :instructions
      t.integer :user_id
      t.boolean :pending,:default =>false
      t.boolean :open,:default =>true

      t.timestamps
    end
  end
end
