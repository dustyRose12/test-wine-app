class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.decimal :rating, precision: 2, scale: 1
      t.text :description
      t.integer :user_id
      t.integer :wine_id

      t.timestamps
    end
  end
end
