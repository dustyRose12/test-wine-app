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

  def user_rating

    wine_all_ratings = reviews.map { |review| review.rating }

    wine_ratings = wine_all_ratings.compact

    if existing_avg_user_rating > 0
        if wine_ratings.empty?
          @user_rating_avg = existing_avg_user_rating
        else
          @user_rating_avg = (((wine_ratings.sum.to_f/ wine_ratings.size)+ existing_avg_user_rating)/2).round(1) 
        end
    else
       if wine_ratings.empty?
          @user_rating_avg = nil
        else
          @user_rating_avg = (wine_ratings.sum.to_f/ wine_ratings.size).round(1) 
        end
    end
      

    if @user_rating_avg
      if @user_rating_avg > 0
       return @user_rating_avg
      else 
        return nil
      end
    else
      return nil
    end

  end

  def user_rating_for_sort
    if self.user_rating
      return self.user_rating
    else
      return 0
    end
  end

  def user_rating_for_sort_highest
    if self.user_rating
      return self.user_rating
    else
      return 0 #so the N/As float to the bottom
    end
  end

  def user_rating_for_sort_lowest
    if self.user_rating
      return self.user_rating
    else
      return 10000 #so the N/As float to the bottom
    end
  end

  def user_rating_count
  wine_ratings = reviews.map { |review| review.rating }

   if @user_rating_avg == "N/A"
      return @user_rating_count = 0
   else
     if wine_ratings.empty?
        return @user_rating_count = existing_avg_user_rating_count
      else
        return @user_rating_count = wine_ratings.size + existing_avg_user_rating_count
      end
      
    end

  end

  def full_stars

    if self.user_rating
        return self.user_rating.truncate.to_i
    else
      0
    end
  end

  def half_stars
     if self.user_rating
         decimal = self.user_rating.modulo(1)
         if decimal == 0 || decimal == 0.1 || decimal == 0.2
          return 0
        else
          return 1
        end
    else
      return 0
    end 
  end

  def half_empty_stars
    if self.half_stars > 0
      return 1
    else
      return 0
    end
  end

  def full_empty_stars
    if self.user_rating
      return (5 - self.full_stars - self.half_stars)
    else
      return 5
    end
  end

  def region_empty?
    if self.region.name == ""
      true
    else
      false
    end
  end

  def overall_rating
    if expert_rating
      expert_rating_normalized = expert_rating * 0.05
      if user_rating
        if user_rating > 0
          return ((expert_rating_normalized + user_rating) / 2).round(1)
        else
          return expert_rating_normalized.round(1)
        end
      else
        expert_rating_normalized.round(1)
      end

    else
      if user_rating
        if user_rating > 0
          return user_rating
        else
          return 0
        end
      else
            overall_rating = 0
      end
    end
  end

   def overall_rating_for_sort_highest
    if self.overall_rating > 0
      return overall_rating
    else
      return 0 #so the N/As go to the bottom
    end
  end

  def overall_rating_for_sort_lowest
    if self.overall_rating > 0
      return overall_rating
    else
      return 10000 #so the N/As go to the bottom
    end
  end

  def overall_rating_for_show
    if self.overall_rating > 0
      return overall_rating
    else
      return "N/A"
    end
  end

  def expert_rating_for_show
    if expert_rating
      expert_rating
    else
      return "N/A"
    end

  end

  def expert_rating_for_sort
    if expert_rating
      expert_rating
    else
      return 0
    end
  end

  def expert_rating_for_sort_highest
    if expert_rating
      expert_rating
    else
      return 0 #so the N/As go to the bottom of the results
    end
  end

  def expert_rating_for_sort_lowest
    if expert_rating
      expert_rating
    else
      return 10000 #so the N/As go to the bottom of the results
    end
  end

  def user_rating_for_show
    if user_rating
      user_rating
    else
      return "N/A"
    end

  end

  def price_for_sort_lowest
    if price
      price
    else
      return 10000 #made this really high so that the N/A prices show up at the end of the results
    end
  end

   def price_for_sort_highest
    if price
      price
    else
      return 0 #made this really low so that the N/A prices show up at the end of the results
    end
  end

  def price_for_show
    if price
      price
    else
      return "N/A"
    end
  end

  def vintage_for_show
    if vintage == 0
      return "N/A"
    else
      vintage
    end
  end

  def vintage_for_sort_lowest
     if vintage == 0
      return 10000 #made this really high so that the N/A prices show up at the end of the results
    else
      vintage
    end
  end

   def vintage_for_sort_highest
     if vintage == 0
      return 0 #made this really low so that the N/A prices show up at the end of the results
    else
      vintage
    end
  end

  # def sort_attribute_select(sort_attribute)
  #   if sort_attribute == "price"
  #     self.price_for_sort_highest
  #   elsif sort_attribute == "expert_rating"
  #     self.expert_rating_for_sort_highest
  #   elsif sort_attribute == "vintage"
  #     self.vintage_for_sort_highest
  #   end
  # end


  def self.random
    wines = Wine.all
    all_ids = []
    wines.each do |wine|
      all_ids << wine.id
    end
    all_ids.sample

  end

  def self.search(search_term)
      wines = []

      if Wine.by_country(search_term).any? #search by Country
        wines <<  Wine.by_country(search_term)   

      elsif Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%").any? #search by Producer
        wines << Wine.joins(:producer).where("producers.name iLIKE ?", "%#{search_term}%")

      elsif Wine.where("name iLIKE ?", "%#{search_term}%").any? #search by Name
        wines << Wine.where("name iLIKE ?", "%#{search_term}%")

      elsif Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%").any? #search by Varietal
        wines << Wine.joins(:varietal).where("varietals.name iLIKE ?", "%#{search_term}%") 

      elsif Wine.joins(:region).where("regions.name iLIKE ?", "%#{search_term}%").any? #search by Region
        wines << Wine.joins(:region).where("regions.name iLIKE ?", "%#{search_term}%") 

      end

      return wines.flatten.uniq
      
  end
  
  def self.by_country(country_name)
    country = Country.where('name ILIKE ?', "%#{country_name}%").first
    return [] unless country
    Wine.includes(:region).where(regions: { country_id: country.id } )
  end

  def self.varietal_types(param)
    if param == 'Red'
      ['Bordeaux Red Blends', 'Cabernet Sauvignon', 'Grenache', 'Malbec', 'Merlot', 'Montepulciano','Pinot Noir', 'Red Blends', 'Sangiovese', 'Syrah/Shiraz', 'Tempranillo', 'Zinfandel']
    elsif param == 'White'
      ['Albariño','Chardonnay', 'Chenin Blanc', 'Pinot Gris/Grigio', 'Riesling', 'Sauvignon Blanc', 'Viognier', 'White Blends']
    elsif param == 'Rosé'
      ['Rosé']
    elsif param == 'Sparkling and Champagne'
      ['Sparkling and Champagne']
    elsif param == 'Dessert'
      ['Other: Dessert']
    elsif param == 'Sherry, Port, Madeira'
      ['Other: Sherry, Port, Madeira']
    elsif param
      ['Albariño', 'Chardonnay', 'Cabernet Sauvignon', 'Grenache', 'Malbec', 'Merlot', 'Montepulciano','Pinot Gris/Grigio','Pinot Noir', 'Red Blends', 'Riesling', 'Rosé', 'Sangiovese', 'Sauvignon Blanc', 'Sparkling and Champagne', 'Syrah/Shiraz', 'Tempranillo', 'Zinfandel', 'White Blends']
    end
  end

   def self.country_types(param)
    if param == 'Red' or param == 'White' or param == 'Rosé' or param == 'Sparkling and Champagne' or param == 'Dessert' or param == 'Sherry, Port, Madeira'
     return ['Argentina', 'Australia', 'Chile', 'France', 'Germany', 'Italy', 'New Zealand', 'Portugal', 'Spain', 'South Africa', 'US']
    end
    Varietal.all.each do |var|
      if param == var.name
        return ['Argentina', 'Australia', 'Chile', 'France', 'Germany', 'Italy', 'New Zealand', 'Portugal', 'Spain', 'South Africa', 'US']
      end
    end
    # if param == "vintage" or param == "price" or param == "expert_rating" or param == "user_rating" or param == "overall_rating" or param == "search_term"
    if param
      return ['Argentina', 'Australia', 'Chile', 'France', 'Germany', 'Italy', 'New Zealand', 'Portugal', 'Spain', 'South Africa', 'US']
    end
  end

  def self.region_types(param)
      if param == 'Red' or param == 'White' or param == 'Rosé' or param == 'Sparkling and Champagne' or param == 'Dessert' or param == 'Sherry, Port, Madeira'
        return ['Alsace', 'Bordeaux', 'Burgundy', 'Champagne', 'Jerez', 'Napa Valley, California', 'Mosel', 'Rioja', 'Sonoma, California', 'Tuscany', 'Washington']
     else
        Varietal.all.each do |var|
         if param == var.name
          return ['Alsace', 'Bordeaux', 'Burgundy', 'Champagne', 'Jerez', 'Napa Valley, California', 'Mosel', 'Rioja', 'Sonoma, California', 'Tuscany', 'Washington']
         end
        end
      end

   end

   def self.wine_type(param)
    # Country.all.each do |country|
      if param
        return ['Red', 'White', 'Rosé', 'Sparkling and Champagne', 'Dessert', 'Sherry, Port, Madeira']
      end
    # end

  end

  # FIX LATER IF HAVE TIME to account for time
  def self.wine_of_day
    start_time = Time.now.utc
    one_day_later = start_time + 1.day
    today_wine = Wine.order("RANDOM()").take(1)

  end


end


