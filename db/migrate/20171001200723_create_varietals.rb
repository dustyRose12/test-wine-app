class CreateVarietals < ActiveRecord::Migration[5.1]
  def change
    create_table :varietals do |t|
      t.string :name
      t.string :wine_type

      t.timestamps
    end
  end
end
