class PersonalCategory < ApplicationRecord

  belongs_to :user

  has_many :personal_category_pins
  has_many :pins, through: :personal_category_pins
  
end
