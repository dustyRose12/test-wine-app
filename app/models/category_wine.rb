class CategoryWine < ApplicationRecord

  belongs_to :wine
  belongs_to :category
end
