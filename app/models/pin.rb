class Pin < ApplicationRecord

  belongs_to :wine
  belongs_to :user

  has_many :personal_category_pins
  has_many :personal_categories, through: :personal_category_pins

  validates :user_id, uniqueness: { scope: :wine_id,
    message: "already has this wine in their Cellar!" }


end
