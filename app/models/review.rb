class Review < ApplicationRecord

  belongs_to :wine
  belongs_to :user

  validates :user_id, uniqueness: { scope: :wine_id,
    message: "has already reviewed this wine!" }

  validates :rating, presence: { message: "must be included in your Review. Your Review was not submitted." }

end
