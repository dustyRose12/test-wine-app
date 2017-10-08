class RemoveRatingFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :rating, :decimal, precision: 2, scale: 1
  end
end
