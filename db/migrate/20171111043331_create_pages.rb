class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :region_name
      t.string :region_country
      t.text :description
      t.string :url
      t.string :link_for_more

      t.timestamps
    end
  end
end
