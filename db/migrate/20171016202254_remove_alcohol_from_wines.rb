class RemoveAlcoholFromWines < ActiveRecord::Migration[5.1]
  def change
        remove_column :wines, :alcohol, :string
  end
end
