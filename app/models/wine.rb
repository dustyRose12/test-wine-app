class Wine < ApplicationRecord

  belongs_to :region
  belongs_to :producer
  belongs_to :varietal

  has_many :images

  has_many :category_wines
  has_many :categories, through: :category_wines

  has_many :reviews
  # has_many :users, through: :reviews not sure what to call the wine's users so that it is not confused with the pinned wines users  
  has_many :pins
  has_many :users, through: :pins


  def default_image
    if images.count > 0
      images.first.url
    else
      "https://i.pinimg.com/736x/d2/ac/37/d2ac37f6a442f7e47c8fab9bc51c22cc--wine-logo-online-pharmacy.jpg"
    end
  end

  def user_rating
    # wines = Wine.all
    # wine_reviews = []

    # wines.each do |wine|
    #   wine_reviews << Review.where({ wine_id: wine.id }).pluck(:rating)
    # end

    # user_rating_avg = wine_reviews.sum / wine_reviews.size
    # if user_rating_avg
    #   return user_rating_avg
    # else
      return 4.5
    # end

  end

  def overall_rating
    user_rating_normalized = user_rating * 20
    overall_rating = (expert_rating + user_rating_normalized) / 2
  end


  def self.random
    wines = Wine.all
    all_ids = []
    wines.each do |wine|
      all_ids << wine.id
    end
    all_ids.sample

  end

  #FINISH LATER, for all other search terms
  def self.search(search_term)
      wines = []

      if Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%").any?
        wines << Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%")
      elsif Wine.where("name iLIKE ?", "%#{search_term}%").any?
        wines << Wine.where("name iLIKE ?", "%#{search_term}%")
      elsif Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%").any?
        wines << Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%") 
      end

      return wines.flatten.uniq
      
  end
end
