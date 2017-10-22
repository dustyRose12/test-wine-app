class RemoveMlFromWines < ActiveRecord::Migration[5.1]
  def change
        remove_column :wines, :ml, :integer
  end
end
