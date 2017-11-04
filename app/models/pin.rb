class Pin < ApplicationRecord

  belongs_to :wine
  belongs_to :user

  has_many :personal_category_pins
  has_many :personal_categories, through: :personal_category_pins

  validates :user_id, uniqueness: { scope: :wine_id,
    message: "already has this wine in their Cellar!" }


  # def personal_category_count
  #   count = PersonalCategory.where(user_id: current_user.id).count
  # end

  # def all_personal_categories
  #   personal_categories = PersonalCategory.where(user_id: current_user.id)
  # end

  # def non_empty_personal_categories
  #   personal_categories = PersonalCategory.where(user_id: current_user.id)
  # end

end
