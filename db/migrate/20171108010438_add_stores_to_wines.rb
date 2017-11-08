class AddStoresToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :store_one, :string
    add_column :wines, :link_one, :text
    add_column :wines, :store_two, :string
    add_column :wines, :link_two, :text
    add_column :wines, :store_three, :string
    add_column :wines, :link_three, :text

  end
end
