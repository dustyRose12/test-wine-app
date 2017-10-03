class Region < ApplicationRecord

  has_many :wines
  belongs_to :country
end
