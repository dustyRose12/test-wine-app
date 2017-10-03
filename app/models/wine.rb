class Wine < ApplicationRecord

  belongs_to :region
  belongs_to :producer
  belongs_to :varietal

  has_many :images

  has_many :category_wines
  has_many :categories, through: :category_wines

  has_many :reviews
  has_many :pins
end
