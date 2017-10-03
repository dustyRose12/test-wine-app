class Category < ApplicationRecord

  has_many :category_wines
  has_many :wines, through: :category_wines
end
