class AddExpertReviewToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :expert_review, :text
  end
end
