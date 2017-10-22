class ChangeExpertRatingFromWines < ActiveRecord::Migration[5.1]
  def change
    change_column :wines, :expert_rating, :decimal, precision: 3, scale: 1
  end
end
