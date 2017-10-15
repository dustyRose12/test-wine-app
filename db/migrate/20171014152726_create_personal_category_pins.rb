class CreatePersonalCategoryPins < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_category_pins do |t|
      t.integer :personal_category_id
      t.integer :pin_id

      t.timestamps
    end
  end
end
