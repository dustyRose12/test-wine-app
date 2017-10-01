class CreateWines < ActiveRecord::Migration[5.1]
  def change
    create_table :wines do |t|
      t.integer :producer_id
      t.string :name
      t.integer :varietal_id
      t.integer :vintage
      t.integer :region_id
      t.decimal :price, precision: 7, scale: 2
      t.integer :expert_rating
      t.string :alcohol
      t.integer :ml
      t.text :description

      t.timestamps
    end
  end
end
