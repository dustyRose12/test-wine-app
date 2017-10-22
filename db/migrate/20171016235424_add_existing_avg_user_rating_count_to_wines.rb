class AddExistingAvgUserRatingCountToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :existing_avg_user_rating_count, :integer
  end
end
