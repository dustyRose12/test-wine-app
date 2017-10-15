class Wine < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'

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

  def user_rating(wine_id)
    this_wine = Wine.find(wine_id)
    wine_ratings = []

    this_wine.reviews.each do |review|
      wine_ratings << review.rating
    end

    @user_rating_avg = wine_ratings.sum.to_f / wine_ratings.size

    if @user_rating_avg > 0
      return @user_rating_avg
    else
      return "N/A"
    end

  end

  def overall_rating
    if @user_rating_avg > 0
      user_rating_normalized = @user_rating_avg * 20
      overall_rating = (expert_rating + user_rating_normalized) / 2
    else
      overall_rating = expert_rating
    end
  end


  def self.random
    wines = Wine.all
    all_ids = []
    wines.each do |wine|
      all_ids << wine.id
    end
    all_ids.sample

  end

  #FINISH LATER, need to add Country search
  def self.search(search_term)
      wines = []

      if Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%").any? #search by Producer
        wines << Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%")

      elsif Wine.where("name iLIKE ?", "%#{search_term}%").any? #search by Name
        wines << Wine.where("name iLIKE ?", "%#{search_term}%")

      elsif Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%").any? #search by Varietal
        wines << Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%") 

      elsif Wine.joins(:region).where("regions.name iLIKE ?", "%#{search_term}%").any? #search by Region
        wines << Wine.joins(:region).where("regions.name iLIKE ?", "%#{search_term}%") 

      # search by Country, NOT WORKING  
      # elsif Wine.includes(:region).where("regions.country.name iLIKE ?", "%#{search_term}%").any? #search by Country
      #   wines << Wine.includes(:region).where("region.countries.name iLIKE ?", "%#{search_term}%") 

      end

      return wines.flatten.uniq
      
  end
end
