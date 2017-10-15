class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  # has_many :reviewed_wines, through: :reviews not sure what to call the reviewed_wines so that it is not confused with the pinned wines when calling user.wines
  has_many :pins
  has_many :wines, through: :pins

  has_many :personal_categories
  

end
