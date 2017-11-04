class PersonalCategoryPin < ApplicationRecord

  belongs_to :pin
  belongs_to :personal_category 

  validates :pin_id, uniqueness: { scope: :personal_category_id }
end
