class AddUpcToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :upc, :string
  end
end
