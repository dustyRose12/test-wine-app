require 'nokogiri'
require 'open-uri'

wines = []


1.times do |counter|

  wine_hash = {}

  doc = Nokogiri::HTML(open("https://www.wine.com/product/peter-michael-point-rouge-chardonnay-2014/#{178214+ counter}"))

  break if doc.css('.pipName').empty?

  #grab name, varietal, vintage
  wine_hash[:name] = doc.css('.pipName').first.content
  wine_hash[:varietal] = doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.pipOrigin span.prodItemInfo_varietal').text
  wine_hash[:vintage] = doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo h1.pipName').text.split(//).last(4).join.to_i
   wine_hash[:producer] = doc.css('html body div.mobilePage div.scrollableContent main section.pipSecContent div.pipWinery div.pipWinery_overlay div.pipWinery_header h2.pipWinery_headline').text

#grab wine_type
  if doc.at_css('div.prodInfo ul.prodAttr li.icon.icon-glass-white.prodAttr_icon.prodAttr_icon-whiteWine')
    wine_hash[:wine_type] = "White Wine"

  elsif doc.at_css('div.prodInfo ul.prodAttr li.icon.icon-glass-red.prodAttr_icon.prodAttr_icon-redWine')
    wine_hash[:wine_type] = "Red Wine"
  
  elsif doc.at_css('div.prodInfo ul.prodAttr li.icon.icon-glass-white.prodAttr_icon.prodAttr_icon-roseWine')
    wine_hash[:wine_type] = "Rosé"
  
  elsif doc.css('div.prodInfo ul.prodAttr li.icon.icon-champagne.prodAttr_icon.prodAttr_icon-champagne')
    wine_hash[:wine_type] = "Sparkling & Champagne"
  else
    wine_hash[:wine_type] = "Dessert, Sherry & Port"
  end

  #grab region
 region_plus_country = doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.pipOrigin span.prodItemInfo_originText').text

 region_plus_country = region_plus_country.split
 region_plus_country.pop
 region = region_plus_country.join(" ")
 wine_hash[:region] = region.chop

 #grab country, modifies region if it was a US state
  country = doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.pipOrigin span.prodItemInfo_originText').text.split.last

  states = ["California", "New York", "Washington", "Oregon", "Pennsylvania", "Ohio", "Kentucky", "Florida", "New Jersey", "Texas"]

  if states.include?(country)
    wine_hash[:country] = "US"
    wine_hash[:region] = wine_hash[:region] + ", " + country
  else
    wine_hash[:country] = country
  end

  #grab price
  price = doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.prodOffer div.productPrice div.productPrice_price-reg span.productPrice_price-regWhole').text

  if (price.empty? )
    wine_hash[:price] = nil
  else
    wine_hash[:price] = price.to_i
  end

  #grab description, image_url
  wine_hash[:description] = doc.css('.viewMoreModule_text').first.content

 


  wine_hash[:image_url] = "www.wine.com" + doc.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipHero.lightBox div.pipHero_container_wrapper div.pipHero_container picture.pipHero_image img.pipHero_image').attr('src')

  #grab expert_rating
  expert_ratings = doc.css('ul.wineRatings_list li.wineRatings_listItem span.wineRatings_rating')
  expert_ratings_arr = []
  expert_ratings.each do |rating|
    expert_ratings_arr << rating.text.to_i
  end

  rating_avg = expert_ratings_arr.inject{ |sum, el| sum + el }.to_f / expert_ratings_arr.size

  if (rating_avg > 0)
    wine_hash[:expert_rating] = rating_avg
  else
    wine_hash[:expert_rating] = nil
  end

  #grab critic reviews (maybe use for later, categories of earthy, oaky etc)
  node = doc.at_css('div.pipProfessionalReviews_list p.pipProfessionalReviews_review span.pipSecContent_copy')

  if node
      wine_hash[:professional_reviews] = node.content
  else
    wine_hash[:professional_reviews] = "N/A"
  end

  #grab user_ratings if avail:
  no_rating = doc.css('div.averageRating.js-is-hidden')
  rating = doc.css('span.averageRating_average').text
  count = doc.css('span.averageRating_number').text

  rating_legit = rating.to_f.round(1)
  rating_count_real_length = count.length/2
  count_legit = count[0..(rating_count_real_length-1)]

  wine_hash[:user_rating] = rating_legit
  wine_hash[:user_rating_count] = count_legit.to_i


  wines << wine_hash


  end

  p wines




p "=================================="

# [

#   {:name=>"Peter Michael Point Rouge Chardonnay 2014", 
#     :varietal=>"Chardonnay", 
#     :vintage=>2014, 
#     :producer=>"Peter Michael", 
#     :wine_type=>"White Wine", 
#     :region=>"Sonoma County, California", 
#     :country=>"US", 
#     :price=>499, 
#     :description=>"Elegant, complex and rich, the 2014 Point Rouge is an exceptional wine. The nose is filled with aromas of vine blossom, ripe apple, citrus oils, orange rind, William pear, almond and acacia honey. Seamless and rich in the mouth, notes of mangosteen, green gage, crème brûlée, honeysuckle, vanilla, spice cake and white truffle are framed with an oyster shell minerality. The wine offers a rare harmony as well as extraordinary tactile persistence. Already refined, the wine will gain even more complexity in 4-5 years and should continue to age gracefully for two decades.", 
#     :image_url=>"www.wine.com/labels/166067h.jpg", 
#     :expert_rating=>97.0, 
#     :professional_reviews=>"One of two wines flirting with perfection (much like the 2012 has already achieved), the 2014 Chardonnay Point Rouge (275 cases in this
#      vintage vs. 165 in 2013) is usually a selection by Nic Morlet and his brother Luc of the finest barrels in the cellar. Much of it comes from the old vines of Belle Côte. The 2014 comes across like a great Bâtard-Montrachet, with buttery apple notes intermixed with white peach, orange marmalade, caramelized citrus, great acid, full-bodied power, and a stunningly long finish of almost 45 seconds. It is often one of the three or four finest Chardonnays made in the world, and appears to be so in 2014. Drink it over the next decade, although they tend to last even longer. (The 2001 I just tasted was amazing.)", 
#      :user_rating=>4.8, 
#      :user_rating_count=>2}, 


#   {:name=>"Peter Michael Ma Danseuse Pinot Noir 2014", 
#     :varietal=>"Pinot Noir", 
#     :vintage=>2014, 
#     :producer=>"Peter Michael", 
#     :wine_type=>"Red Wine", 
#     :region=>"Sonoma Coast, Sonoma County, California", 
#     :country=>"US", 
#     :price=>nil, 
#     :description=>"This wine charms the eye with a red ruby color and bright crimson highlights. The nose is marked with notes of rose, raspberry, Griotte cherry, strawberry and forest floor. Delicate, fragrant, complete and refined, on the palate the 2014 Ma Danseuse has a wonderful concentration of red fruit and rose blossom, with subtle savory notes of sandalwood, leather, clove, hazelnut, mineral and cigar box, which embraces a silky texture and lingering aromatic finish. It will continue to express its potential for two decades.", 
#     :image_url=>"www.wine.com/labels/166068h.jpg", 
#     :expert_rating=>96.5, 
#     :professional_reviews=>"Wonderful perfumes with blackberry, cherry and cloves. Violet. Full body, extremely focused and clear fruit. Bright and vivid. Crunchy and juicy. Precise and fruity. Love the layers and flavors. Irresistible.", 
#     :user_rating=>0.0, 
#     :user_rating_count=>0}, 


# {:name=>"Quilceda Creek Palengat Vineyard Red Blend 2013", 
#   :varietal=>"Bordeaux Red Blends", 
#   :vintage=>2013, 
#   :producer=>"Quilceda Creek Vintners", 
#   :wine_type=>"Red Wine", 
#   :region=>"Yakima Valley, Columbia Valley, Washington", 
#   :country=>"US", 
#   :price=>149, 
#   :description=>"The 2013 Quilceda Creek Palengat Proprietary Red Wine was sourced from Champoux, Palengat, Lake Wallula and Wallula Gap Vineyards which are located in the Horse Heaven Hills AVA. This exotic Merlot-based wine displays beautiful layers of aromatic plum and black cherry fruit with nuances of anise, soy, graphite and minerals. It has stunning purity and delineation, with superfine tannins. Aged in 100% new French oak for 20 months.\nBlend: 58% Merlot, 30% Cabernet Sauvignon, and 12% Cabernet Franc ", 
#   :image_url=>"www.wine.com/labels/166069h.jpg", 
#   :expert_rating=>94.0, 
#   :professional_reviews=>"More Merlot dominated in 2013 (they plan to move this back to a more Cabernet Sauvignon dominated blend in the future), the 2013 Palengat Vineyard is another terrific 2013 that makes the most of
#    vintage. Sexy, voluptuous and rounded, with no hard edges, it gives up classic notes of plums, graphite and licorice in its full-bodied, mouth-filling and impossible to resist style. While I’d happily drink a glass (or three) today, it will drink well for another 10-15 years.", 
#    :user_rating=>0.0, 
#    :user_rating_count=>0}, 


# {:name=>"Quilceda Creek Galitzine Vineyard Cabernet Sauvignon 2013", 
#   :varietal=>"Cabernet Sauvignon", 
#   :vintage=>2013, 
#   :producer=>"Quilceda Creek Vintners", 
#   :wine_type=>"Red Wine", 
#   :region=>"Red Mountain, Yakima Valley, Columbia Valley, Washington", 
#   :country=>"US", 
#   :price=>194, 
#   :description=>"The 2013 Quilceda Creek Galitzine Vineyard Cabernet Sauvignon is from the Red Mountain AVA. The 2013 is an awesome wine that displays rich, complex aromas and flavors of classic blackberry and cassis fruit, sweet pipe tobacco, forest floor, and minerals. Aged in 100% new French Oak for 20 months, it is 95% Cabernet Sauvignon from Galitzine Vineyard and 5% Cabernet Sauvignon from Wallula Gap Vineyard.", 
#   :image_url=>"www.wine.com/labels/166070h.jpg", 
#   :expert_rating=>96.0, 
#   :professional_reviews=>"An utterly prodigious effort that would most likely be the wine of the
#    vintage if not for its big brother, the 2013 Cabernet Sauvignon Galitzine Vineyard comes all from Red Mountain and was raised in 100% new French oak. Revealing a healthy ruby/purple color and classic notes of sage brush, graphite, black cherries, currants and chocolate, it hits the palate with full-bodied richness; building, present, yet ripe and polished tannin; perfect integration of its fruit, alcohol and oak; and awesome length. This is a powerhouse Cabernet Sauvignon that still holds onto a sense of elegance and finesse. Forget it for 4-5 years and drink bottles over the following two decades.", 
#    :user_rating=>0.0, 
#    :user_rating_count=>0}, 


# {:name=>"Banfi Brunello di Montalcino (1.5 Liter Magnum) 2010", 
#   :varietal=>"Sangiovese", 
#   :vintage=>2010, 
#   :producer=>"Castello Banfi", 
#   :wine_type=>"Red Wine", 
#   :region=>"Montalcino, Tuscany", 
#   :country=>"Italy", 
#   :price=>nil, 
#   :description=>"Intense ruby red in color with garnet reflections. Aromas of violets and vanilla, with hints of licorice. Velvety palate, with tart-cherry flavors and traces of spice. Well structured with supple tannins, superb concentration, and good acidity. Persistent finish.", 
#   :image_url=>"www.wine.com/labels/166071h.jpg", 
#   :expert_rating=>92.2, 
#   :professional_reviews=>"Fabulous aromas of dried rose petal, orange peel, oyster shell and hints of dark fruits. Full body, very fine tannins with a mineral, berry and orange-peel and Tuscan-dust undertone. A structured, salty, savory finish. Better in 2017.", 
#   :user_rating=>0.0, 
#   :user_rating_count=>0}, 


# {:name=>"Uvaggio Passito Vermentino (500ML)", 
#   :varietal=>"Other Dessert", 
#   :vintage=>0, 
#   :producer=>"Uvaggio", 
#   :wine_type=>"Sparkling & Champagne", 
#   :region=>"Lodi, California", 
#   :country=>"US", 
#   :price=>21, 
#   :description=>"From Liguria in Italy’s north, south to the island of Pantelleria (between Sicily and Tunisia) unique Passito wines are made from dried grapes, as they have been for centuries, since the era of the Phoenicians.The dried fruit was pressed, yielding only about half the juice as is normal. It was filled to barrels allowing the native yeasts to slowly ferment, after which it was aged for almost a year. The golden yellow color is a result of not using any SO2 until bottling.  ", 
#   :image_url=>"www.wine.com/labels/166072h.jpg", 
#   :expert_rating=>92.0, 
#   :professional_reviews=>"Full body and powerfully fruity flavors make this sweet wine seem extra bold. It smells like toasted almonds and dried meat and tastes like poached peaches. A smooth but lively texture keeps the flavors zinging on the finish.Editors' Choice", 
#   :user_rating=>0.0, 
#   :user_rating_count=>0}, 


# {:name=>"Patricia Green Reserve Pinot Noir 2015", 
#   :varietal=>"Pinot Noir", 
#   :vintage=>2015, 
#   :producer=>"Patricia Green", 
#   :wine_type=>"Red Wine", 
#   :region=>"Willamette Valley, Oregon", 
#   :country=>"US", 
#   :price=>24, 
#   :description=>"This wine is a smoking deal! We work with 8 Pinot Noir vineyards, all of which we make at least one vineyard designated bottling from, and this bottling simply takes the barrels that are more precocious or don’t fit in with the profile of the vineyard designated bottling. 75% of this comes from Ribbon Ridge and Chehalem Mountains AVAs, 15% comes from the Dundee Hills AV and the rest, while designated Willamette Valley AVA is all from Freedom Hill Vineyard. There are seriously great bones here and this wine will stand up to many, many much higher
#    priced\nbottlings.", 
#    :image_url=>"www.wine.com/labels/166073h.jpg", 
#    :expert_rating=>nil, 
#    :professional_reviews=>"N/A", 
#    :user_rating=>4.8, 
#    :user_rating_count=>2}, 


# {:name=>"El Enemigo Mendoza Gran Enemigo 2010", 
#   :varietal=>"Other Red Blends", 
#   :vintage=>2010, 
#   :producer=>"El Enemigo", 
#   :wine_type=>"Red Wine", 
#   :region=>"Mendoza", 
#   :country=>"Argentina", 
#   :price=>90, 
#   :description=>"The nose presents sweet aromas of black ripen fruits with hints of vanilla and chocolate, which appear after the oak ageing. The mouthfeel is sweet with structured, persistent tannins due to the natural acidity of this wine, leading into an excellent long finish. \nThis wine pairs well with grilled meat, cheese, or slow roasted beef dishes.", 
#   :image_url=>"www.wine.com/labels/166074h.jpg", 
#   :expert_rating=>95.0, 
#   :professional_reviews=>"A wonderful red with complex aromas and flavors of blackberry, mineral, stone and earth. Full body, pure fruit and great beauty. Incredible layers and subtlety. Drink now. A blend of cabernet franc, petit verdot, cabernet sauvignon and merlot, aged 13 to 24 months in large 100-year-old Gamba casks. Wow.", 
#   :user_rating=>4.2, 
#   :user_rating_count=>2}, 


# {:name=>"Gregory Graham Magma Red 2012", 
#   :varietal=>"Bordeaux Red Blends", 
#   :vintage=>2012, 
#   :producer=>"Gregory Graham", 
#   :wine_type=>"Red Wine", 
#   :region=>"Red Hills, Lake County, North Coast, California", 
#   :country=>"US", 
#   :price=>27, 
#   :description=>"The wine exhibits aromas of ripe plum and chocolate/mocha, with highlights of mint and dried herbs. The lively concentrated flavor bursts with ripe berries and sweet oak. This structured wine is best enjoyed with slow cooked ribs or stews.", 
#   :image_url=>"www.wine.com/labels/166075h.jpg", 
#   :expert_rating=>nil, 
#   :professional_reviews=>"N/A", 
#   :user_rating=>0.0, 
#   :user_rating_count=>0}, 


# {:name=>"Joseph Drouhin Gevrey-Chambertin 2014", 
#   :varietal=>"Pinot Noir", 
#   :vintage=>2014, 
#   :producer=>"Joseph Drouhin", 
#   :wine_type=>"Red Wine", 
#   :region=>"Gevrey-Chambertin, Cote de Nuits, Cote d'Or, Burgundy", 
#   :country=>"France", 
#   :price=>nil, 
#   :description=>"Gevrey-Chambertin is a wine with a beautiful, bright ruby color. Intensely fruity on the nose, the aromas are reminiscent of black cherry, wild blackberry and licorice. The woody character is subtle and marries delicately with the other aromas. As the wine evolves, there are more complex notes, such as mild spice, nutmeg and leather. Later still, mushroom and damp earth nuances make their appearance. Although present on the palate, tannin is never astringent but blends itself harmoniously with the natural freshness and 'gras' (velvety texture) of the wine. The same aromas encountered earlier on the nose are found again in the aftertaste.", 
#   :image_url=>"www.wine.com/labels/166076h.jpg", 
#   :expert_rating=>92.0, 
#   :professional_reviews=>"Rich and inviting, featuring cherry, strawberry and spice flavors that remain persistent through the finish. Balanced, with civilized tannins and excellent length. Best from 2019 through 2032. 700 cases imported.", 
#   :user_rating=>2.5, 
#   :user_rating_count=>1}]

