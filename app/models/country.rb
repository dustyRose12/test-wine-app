class Country < ApplicationRecord

  has_many :regions
  has_many :wines, through: :regions
  
end
