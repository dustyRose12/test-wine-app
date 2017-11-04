class PersonalCategory < ApplicationRecord

  belongs_to :user

  has_many :personal_category_pins # :dependent => :destroy
  has_many :pins, through: :personal_category_pins

  validates :user_id, uniqueness: { scope: :name,
    message: "already has this Category in their Cellar!" }
  
end
