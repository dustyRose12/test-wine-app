class AddExistingAvgUserRatingToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :existing_avg_user_rating, :decimal, precision: 2, scale: 1
  end
end
