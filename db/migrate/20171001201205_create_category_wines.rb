class CreateCategoryWines < ActiveRecord::Migration[5.1]
  def change
    create_table :category_wines do |t|
      t.integer :wine_id
      t.integer :category_id

      t.timestamps
    end
  end
end
