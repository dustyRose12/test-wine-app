class Pin < ApplicationRecord

  belongs_to :wine
  belongs_to :user

  has_many :personal_category_pins
  has_many :personal_categories, through: :personal_category_pins


end
