class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  # has_many :reviewed_wines, through: :reviews not sure what to call the reviewed_wines so that it is not confused with the pinned wines when calling user.wines
  has_many :pins
  has_many :wines, through: :pins

  has_many :personal_categories
  
  def default_profile_pic
    if self.profile_pic.to_s.empty?
     "https://thesocietypages.org/socimages/files/2009/05/nopic_192.gif"
    else
      profile_pic
    end
  end



end
