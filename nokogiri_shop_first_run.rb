require 'nokogiri'
require 'open-uri'


  wines_all = [ 

  {:name=>"Stag's Leap Wine Cellars Artemis Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Stag's Leap Wine Cellars", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>60, :description=>"Artemis Cabernet Sauvignon opens with intriguing plum, ripe figand allspice aromas. On the palate, the wine offers flavors of ripe blackberry, chocolate-covered cherry and hints of cedar. There’s a nice palate weight and texture with ample, yet fine-grained, tannins and a soft finish. Enjoy this Cabernet Sauvignon with Memphis-style dry rub pork or beef ribs, grilled tri-tip, or gnocchi with wild mushrooms, sage and prosciutto.", :image_url=>"www.wine.com/labels/153741h.jpg", :expert_rating=>90.5, :professional_reviews=>"I grew up with the Stag's Leap Wine Cellar wines—drinking and retailing the 1973 when it was first released in the mid-1970s. The wines were exciting then and continued to flourish as one of the bellwethers of the Napa Valley. The 2014 Stag's Leap Wine Cellars ARTEMIS® shows bright red fruits, savory herbs, and light oakiness. The wine's finish makes it perfect for dinner, not just sipping on the patio. Drinks well now. (Tasted: November 2, 2016, San Francisco, CA)", :user_rating=>4.3, :upc=>"0088593700200", :user_rating_count=>119},

    {:name=>"Caymus Napa Valley Cabernet Sauvignon 2015", :varietal=>"Cabernet Sauvignon", :vintage=>2015, :producer=>"Caymus", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>79, :description=>"This wine has a signature style that is dark in color, with rich fruit and ripe, velvety tannins – as approachable in youth as in maturity. Caymus farms Cabernet grapes in eight of Napa’s 16 sub-appellations, with diversification enabling the winery to make the best possible wine in a given year. This Cabernet offers layered, lush aromas and flavors, including cocoa, cassis and ripe dark berries.", :image_url=>"www.wine.com/labels/309394h.jpg", :expert_rating=>91.0, :professional_reviews=>"Another banker from one of the most recognized wines from the Napa Valley, Caymus Vineyards has turned in another solid performance. The 2015 vintage shows up with ripe black fruits, a nice touch of oak, and a smooth roundness on the palate. The wine's ease in the finish pairs it nicely with grilled tri-tip accented with a sweet-sour barbecue glaze. (Tasted: August 23, 2017, San Francisco, CA)", :user_rating=>4.4, :upc=> "0017224712107",:user_rating_count=>104},

  {:name=>"Faust Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Faust", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>55, :description=>"Faust is the epitome of the style that has made Napa Cabernet Sauvignon world renowned: bold and powerful, yet elegant and concentrated. Dense and inky, the core is a beautiful, rich ruby color. The aromas lift out of the glass with blackberry, black cherry, ripe raspberry and tea leaf. The entry is impressive with a fleshy mouthfeel and notes of cassis, dark chocolate and ripe berries. The layers continue to unfold throughout a long finish. ", :image_url=>"www.wine.com/labels/138305h.jpg", :expert_rating=>92.0, :professional_reviews=>"This is very intense with blackberries, dark chocolate, fresh mushrooms and blackcurrants. Full-bodied, fine and fruity yet complex and intense. Structured and lightly austere. Beautiful. Drink in 2020.", :user_rating=>4.3, :upc=> "0859369001254", :user_rating_count=>34},

 {:name=>"Opus One 2014", :varietal=>"Bordeaux Red Blends", :vintage=>2014, :producer=>"Opus One", :wine_type=>"Red Wine", :region=>"Oakville, Napa Valley, California", :country=>"US", :price=>315, :description=>"The 2014 Opus One exudes subtle aromas of fragrant florals, fresh garden herbs and forest floor that give way to a concentrated blend of red cherry, blackberry and black currant. Fine-grained tannins offer a velvety texture and complex structure that builds to a long, vibrantly fresh finish with a touch of mocha. Enjoyable now, the wine will delight for years to come.\nBlend: 80% Cabernet Sauvignon, 7% Petit Verdot, 6% Cabernet Franc, 5% Merlot, 2% Malbec", :image_url=>"www.wine.com/labels/342194h.jpg", :expert_rating=>94.33333333333333, :professional_reviews=>"Mesmerizing aromas of flowers, bark, currants and blackberries. So perfumed. You just want to smell it. Exquisite tension and finesse with an almost Burgundian texture, yet it’s Napa in its soul with ripe fruit, stones, spices and Chinese tea leaf flavors. Savory and delicious. Drinkable but better in 2020.", :user_rating=>4.2, :upc=>"0753604062140", :user_rating_count=>7},

   {:name=>"Duckhorn Napa Valley Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Duckhorn Vineyards", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>75, :description=>"Complex and compelling, this generous wine reflects the diversity of great Napa Valley Cabernet Sauvignon. On the nose, vibrant layers of red and black fruit mingle with hints of violet, dried herbs, black licorice and graphite. The flavors echo the aromas, with lovely black currant and licorice elements supported by firm, impeccably balanced, tannins and an excellent structure. Good acidity helps to carry the juicy dark fruit notes through to a long, satisfying finish. Blend: 83% Cabernet Sauvignon, 13% Merlot, 2% Cabernet Franc, 2% Petit Verdot", :image_url=>"www.wine.com/labels/169807h.jpg", :expert_rating=>91.25, :professional_reviews=>"Duckhorn Vineyards produces one of America's most consistent and delicious Cabernet Sauvignons. The 2014 vintage is another excellent effort. This wine brings ripe cassis and licorice to the fore and combines those flavors with oak and vanilla nuances. Pair now with a juicy Porterhouse steak and savor. (Tasted: March 6, 2017, San Francisco, CA)", :user_rating=>4.1, :upc=> "066957601934", :user_rating_count=>37},

  {:name=>"Meiomi Pinot Noir 2016", :varietal=>"Pinot Noir", :vintage=>2016, :producer=>"Meiomi", :wine_type=>"Red Wine", :region=>"California", :country=>"US", :price=>25, :description=>"A rich garnet color with a ruby edge, the wine opens to reveal lifted fruit aromas of bright strawberry and jammy fruit, mocha, and vanilla, along with toasty oak notes. Expressive boysenberry, blackberry, dark cherry, juicy strawberry, and toasty mocha ?avors lend complexity and depth on the palate. The well-integrated oak provides structure and depth seldom seen in Pinot Noir.", :image_url=>"www.wine.com/labels/215228h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.3, :upc=> "0855165005076", :user_rating_count=>161},

  {:name=>"Belle Glos Dairyman Vineyard Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Belle Glos", :wine_type=>"Red Wine", :region=>"Russian River, Sonoma County, California", :country=>"US", :price=>55, :description=>"Bright crimson red in color. Aromas of black cherry and ripe plums combine with subtle notes of dried herbs and smoke. The palate entry shows flavors of cranberry, fresh raspberry, and ripe cherry, complemented by hints of vanilla and baking spice. A balance of savory, cedar and cocoa powder, and sweet, fig jam and ripe blackberry, round out the mouth-feel. The overall impression is one of ripe red and black berry fruit flavors, great structure, smooth tannins and a lingering fresh finish.", :image_url=>"www.wine.com/labels/167772h.jpg", :expert_rating=>91.0, :professional_reviews=>"Delightfully rich and expressive, with tiers of dark blackberry, mocha, licorice and cherry. Broad and lingering on the deep and persistent finish.", :user_rating=>4.2,  :upc=> "0855622000811", :user_rating_count=>17},

  {:name=>"Saintsbury Carneros Pinot Noir 2014", :varietal=>"Pinot Noir", :vintage=>2014, :producer=>"Saintsbury", :wine_type=>"Red Wine", :region=>"Carneros, California", :country=>"US", :price=>36, :description=>"Pretty, dense aromas of rose petal, dark cherries, cocoa, anise, and cardamom. Sweet cherry and plum entry with a zesty mid palate reminiscent of baking spices, leading into an opulent, elegant, lingering finish. \nThe richness of this wine pairs well with fatty, rich meats, such as lamb, duck, and stewed curries, as well as artisanal cheeses and wild mushrooms.", :image_url=>"www.wine.com/labels/175396h.jpg", :expert_rating=>90.5, :professional_reviews=>"I am often perplexed when I taste and evaluate Pinot Noir—there are no real prototypes of this grape variety. The wines' nuances run the gamut from tart red to very deep black fruits. In the end, one must go with the hedonistic approach and just let each individual wine reveal itself. The 2014 Saintsbury Pinot Noir does an excellent job of showing off its Napa Carneros roots—ripe fruits that run between red and black, textures that are rather substantial, and herbs that show just an accent of savoriness.", :user_rating=>3.0, :upc=> "0732458950773",:user_rating_count=>2},

   {:name=>"Banshee Sonoma County Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Banshee", :wine_type=>"Red Wine", :region=>"Sonoma County, California", :country=>"US", :price=>28, :description=>"This wine leads with a bouquet of red fruits and cherry blossom aromas. The silky palate is layered with notes of cherry, hibiscus, mandarin peel and a faint coppery counterpoint to the fruit. In addition, one might find a hint of dark plum. The finish is fine-boned and harmonious.", :image_url=>"www.wine.com/labels/237120h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.4, :upc=> "0853868006024", :user_rating_count=>5},

  {:name=>"Bread & Butter Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Bread & Butter", :wine_type=>"Red Wine", :region=>"California", :country=>"US", :price=>16, :description=>"This Pinot Noir is all about that juicy red fruit. Think cherries and raspberries with a touch of cassis. Delicate hints of cedar, smoke, and bay leaf cut the sweetness of the fruit, creating a nicely balanced bouquet.That luscious fruit bouquet continues onto the palate, where it’s joined by soft flavors of wood and cured meat, like bacon. With a long and beautifully smooth finish, this Pinot will melt in your mouth. ", :image_url=>"www.wine.com/labels/218385h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.1, :upc=> "0850832004277", :user_rating_count=>8}
      ]


#========================================
# real deal:

main_links = []

sub_links = []
store_names = []

sub_links_2 = []
store_names_2 = []

wine_results = []

10.times do |counter|

doc = Nokogiri::HTML(open("https://www.google.com/search?safe=off&biw=1285&bih=543&tbm=shop&ei=bkUBWoGoK5i9jwSrpI7gAw&q=#{wines_all[counter][:name]}&oq=#{wines_all[counter][:name]}&gs_l=psy-ab.12...0.0.0.1447946.0.0.0.0.0.0.0.0..0.0....0...1..64.psy-ab..0.0.0....0.sqgoIYkB1C8"))


a_tags = doc.css("h3.r a")

a_tags = a_tags.map {|element| element["href"]}.compact

if a_tags[0].slice(0,10) == "/shopping/"
  main_links << "https://www.google.com" + a_tags[0]
  second_scraper = Nokogiri::HTML(open(main_links[counter]))
  sub_links = second_scraper.css('body div#main-content-with-search div#pp-main div#online div#os-content div#os-sellers-content table#os-sellers-table tr.os-row span.os-seller-name-primary a').map {|element| element["href"]}.compact
  store_names  = second_scraper.css('body div#main-content-with-search div#pp-main div#online div#os-content div#os-sellers-content table#os-sellers-table tr.os-row span.os-seller-name-primary a').map {|element| element.content}.compact

  wine_results[counter] = { :wine_name => wines_all[counter][:name], :store_one =>  store_names[0], :link_one => sub_links[0], :store_two => store_names[1], :link_two => sub_links[1], :store_three => store_names[2], :link_three => sub_links[2]  }

else
  main_links << a_tags[0]


  wine_results[counter] = { :wine_name => wines_all[counter][:name], :store_one => "Link to Buy", :link_one => main_links[counter], :store_two => nil, :link_two => nil, :store_three => nil, :link_three => nil  }
end

end


# p wine_results



[{:wine_name=>"Stag's Leap Wine Cellars Artemis Cabernet Sauvignon 2014", 
:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjGy8LS_6zXAhVZucAKHdTUC3AYABABGgJpbQ&sig=AOD64_1t58rYG0lRXPTK_Qrgvm0epExJ-A&ctype=5&ved=0ahUKEwjQkcDS_6zXAhWH8oMKHaorArIQ2ikIDw&adurl=", 
:store_two=>"The House of Glunz", :link_two=>"http://www.google.com/aclk?sa=L&ai=DChcSEwjGy8LS_6zXAhVZucAKHdTUC3AYABADGgJpbQ&sig=AOD64_0G1Ej5keG5xIlKh64aHLgBY8s-sQ&ctype=5&ved=0ahUKEwjQkcDS_6zXAhWH8oMKHaorArIQ2ikIEg&adurl=", 
:store_three=>"The Best Wine Store", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjGy8LS_6zXAhVZucAKHdTUC3AYABAFGgJpbQ&sig=AOD64_0Vf0vUaOjCDp_5bZa3ase24weRyA&ctype=5&ved=0ahUKEwjQkcDS_6zXAhWH8oMKHaorArIQ2ikIFA&adurl="}, 


  {:wine_name=>"Caymus Napa Valley Cabernet Sauvignon 2015", 
:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjWsfHS_6zXAhVCuMAKHb1tDY0YABABGgJpbQ&sig=AOD64_0Y7ssqA9C6IZRq4vVCX1VnbUF0uw&ctype=5&ved=0ahUKEwiW3O_S_6zXAhUl94MKHQJcBeEQ2ikIEw&adurl=", 
:store_two=>"Drizly", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjWsfHS_6zXAhVCuMAKHb1tDY0YABADGgJpbQ&sig=AOD64_0cLz2Acji2qWgyq6kUSNtSCQtQsw&ctype=5&ved=0ahUKEwiW3O_S_6zXAhUl94MKHQJcBeEQ2ikIFg&adurl=", 
:store_three=>"The Best Wine Store", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjWsfHS_6zXAhVCuMAKHb1tDY0YABAFGgJpbQ&sig=AOD64_2oIgQuMAJThSMi4HOyb_-shBSwRg&ctype=5&ved=0ahUKEwiW3O_S_6zXAhUl94MKHQJcBeEQ2ikIGQ&adurl="}, 


  {:wine_name=>"Faust Cabernet Sauvignon 2014", 

:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwii44bT_6zXAhVRXn4KHVc5AtwYABACGgJwYw&sig=AOD64_1Q9Mv9s4u4ctad7-omgPIO7pjBvw&ctype=5&ved=0ahUKEwjJwIPT_6zXAhUsxoMKHThUD5EQ2CkIJDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


  {:wine_name=>"Opus One 2014", 

:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwj1xOTT_6zXAhUIhH4KHTyQA4YYABABGgJwYw&sig=AOD64_3oL1GnhONL4gY0CGrfdUJmZQGEDQ&ctype=5&ved=0ahUKEwjk4OHT_6zXAhXFxYMKHfb6C9AQ2CkIKDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:wine_name=>"Duckhorn Napa Valley Cabernet Sauvignon 2014", 
:store_one=>"B-21 Florida", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwietq_U_6zXAhUDan4KHfZlCcMYABABGgJwYw&sig=AOD64_0X5RLoMPNRzUJLxLLRnGJjJs7vxA&ctype=5&ved=0ahUKEwjR26zU_6zXAhUD4IMKHVJNAYwQ2ikIEQ&adurl=", 
:store_two=>"Wine.com", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwietq_U_6zXAhUDan4KHfZlCcMYABADGgJwYw&sig=AOD64_0WV6cG6dV2L76s_R6QOuEvDcekrQ&ctype=5&ved=0ahUKEwjR26zU_6zXAhUD4IMKHVJNAYwQ2ikIFA&adurl=", 
:store_three=>"Woodland Hills Wine Company", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwietq_U_6zXAhUDan4KHfZlCcMYABAFGgJwYw&sig=AOD64_143h8yLF79XYgD-EoxFhga67471A&ctype=5&ved=0ahUKEwjR26zU_6zXAhUD4IMKHVJNAYwQ2ikIFw&adurl="}, 


{:wine_name=>"Meiomi Pinot Noir 2016", 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwiViuPU_6zXAhVBjX4KHTE_DQYYABABGgJwYw&sig=AOD64_2aAOs3jqtgq62IUEi4JqEd1WfjGw&ctype=5&ved=0ahUKEwjH0d_U_6zXAhUC3YMKHVbSAB4Q2CkIHzAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:wine_name=>"Belle Glos Dairyman Vineyard Pinot Noir 2015", 
:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjw0avV_6zXAhWIX34KHUcMCFgYABABGgJwYw&sig=AOD64_3xbC5XNK4Jckw2c9IN9UY_CpbnoA&ctype=5&ved=0ahUKEwjC6ajV_6zXAhVI4YMKHQ5iDUcQ2ikIDw&adurl=", 
:store_two=>"B-21 Florida", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjw0avV_6zXAhWIX34KHUcMCFgYABADGgJwYw&sig=AOD64_1pWaOSgnF_w78iD7pY5QIhx9JBCw&ctype=5&ved=0ahUKEwjC6ajV_6zXAhVI4YMKHQ5iDUcQ2ikIEg&adurl=", 
:store_three=>"Grapeswine.com", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjw0avV_6zXAhWIX34KHUcMCFgYABAFGgJwYw&sig=AOD64_3D67LE4KcxXpvhZhxSBCUwI_iCww&ctype=5&ved=0ahUKEwjC6ajV_6zXAhVI4YMKHQ5iDUcQ2ikIFQ&adurl="}, 


{:wine_name=>"Saintsbury Carneros Pinot Noir 2014", 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjZ_dPV_6zXAhUObH4KHaqSBVIYABABGgJwYw&sig=AOD64_13nw-1DP1Mdj_KbYATTanMSOX1iw&ctype=5&ved=0ahUKEwiA19DV_6zXAhXj5YMKHT8TCIcQ2CkIHzAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:wine_name=>"Banshee Sonoma County Pinot Noir 2015", 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwijq4PW_6zXAhUJbX4KHSFOA4UYABABGgJwYw&sig=AOD64_2vd-tpM8Fuu3mODpBi4Mj9iYq2Pg&ctype=5&ved=0ahUKEwib-P_V_6zXAhWJ7YMKHatWDugQ2CkIGTAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:wine_name=>"Bread & Butter Pinot Noir 2015", 
:store_one=>"ThinSlim Foods", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwi4lPXW_6zXAhVKkn4KHbblD04YABABGgJwYw&sig=AOD64_0qCic7KO6l262jPxseUeXyrrpGvg&ctype=5&ved=0ahUKEwiLx_LW_6zXAhWmy4MKHbLECCIQ2ikIEw&adurl=", 
:store_two=>"Netrition.com", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwi4lPXW_6zXAhVKkn4KHbblD04YABADGgJwYw&sig=AOD64_0pL9cyXtaaCPVie7Vkolu3c_JLjA&ctype=5&ved=0ahUKEwiLx_LW_6zXAhWmy4MKHbLECCIQ2ikIFQ&adurl=", 
:store_three=>nil, :link_three=>nil}]

#=============================================================================
#=============================================================================
# Recombining shop results into main wine_hash:

# wines_hash_final = []
results_counter = 0

wines_all.each do |hash|
  if hash[:name] == wine_results[results_counter][:wine_name]
     hash[:store_one] = wine_results[results_counter][:store_one]
     hash[:link_one] = wine_results[results_counter][:link_one]
     hash[:store_two] = wine_results[results_counter][:store_two]
     hash[:link_two] = wine_results[results_counter][:link_two]
     hash[:store_three] = wine_results[results_counter][:store_three]
     hash[:link_three] = wine_results[results_counter][:link_three]
  end
  results_counter += 1
end

p wines_all

[{:name=>"Stag's Leap Wine Cellars Artemis Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Stag's Leap Wine Cellars", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>60, :description=>"Artemis Cabernet Sauvignon opens with intriguing plum, ripe figand allspice aromas. On the palate, the wine offers flavors of ripe blackberry, chocolate-covered cherry and hints of cedar. There’s a nice palate weight and texture with ample, yet fine-grained, tannins and a soft finish. Enjoy this Cabernet Sauvignon with Memphis-style dry rub pork or beef ribs, grilled tri-tip, or gnocchi with wild mushrooms, sage and prosciutto.", :image_url=>"www.wine.com/labels/153741h.jpg", :expert_rating=>90.5, :professional_reviews=>"I grew up with the Stag's Leap Wine Cellar wines—drinking and retailing the 1973 when it was first released in the mid-1970s. The wines were exciting then and continued to flourish as one of the bellwethers of the Napa Valley. The 2014 Stag's Leap Wine Cellars ARTEMIS® shows bright red fruits, savory herbs, and light oakiness. The wine's finish makes it perfect for dinner, not just sipping on the patio. Drinks well now. (Tasted: November 2, 2016, San Francisco, CA)", :user_rating=>4.3, :upc=>"0088593700200", :user_rating_count=>119, 
:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwj7t-nSg63XAhWJn34KHZhYBtMYABABGgJwYw&sig=AOD64_3MRBAbCgwOkUd01TP3JBfbfGLuMg&ctype=5&ved=0ahUKEwjnmObSg63XAhUq9YMKHSOPBvoQ2ikIDw&adurl=", 
:store_two=>"The House of Glunz", :link_two=>"http://www.google.com/aclk?sa=L&ai=DChcSEwj7t-nSg63XAhWJn34KHZhYBtMYABADGgJwYw&sig=AOD64_0CyU6h9o3-0jGYYPGiPHFv2ExW9g&ctype=5&ved=0ahUKEwjnmObSg63XAhUq9YMKHSOPBvoQ2ikIEg&adurl=", 
:store_three=>"The Best Wine Store", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwj7t-nSg63XAhWJn34KHZhYBtMYABAFGgJwYw&sig=AOD64_10NoiINVZLp4sNMhQ2NCBmV_J4tA&ctype=5&ved=0ahUKEwjnmObSg63XAhUq9YMKHSOPBvoQ2ikIFA&adurl="}, 


  {:name=>"Caymus Napa Valley Cabernet Sauvignon 2015", :varietal=>"Cabernet Sauvignon", :vintage=>2015, :producer=>"Caymus", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>79, :description=>"This wine has a signature style that is dark in color, with rich fruit and ripe, velvety tannins – as approachable in youth as in maturity. Caymus farms Cabernet grapes in eight of Napa’s 16 sub-appellations, with diversification enabling the winery to make the best possible wine in a given year. This Cabernet offers layered, lush aromas and flavors, including cocoa, cassis and ripe dark berries.", :image_url=>"www.wine.com/labels/309394h.jpg", :expert_rating=>91.0, :professional_reviews=>"Another banker from one of the most recognized wines from the Napa Valley, Caymus Vineyards has turned in another solid performance. The 2015 vintage shows up with ripe black fruits, a nice touch of oak, and a smooth roundness on the palate. The wine's ease in the finish pairs it nicely with grilled tri-tip accented with a sweet-sour barbecue glaze. (Tasted: August 23, 2017, San Francisco, CA)", :user_rating=>4.4, :upc=>"0017224712107", :user_rating_count=>104, 

:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjHwb7Tg63XAhUBaH4KHbYYA4IYABABGgJwYw&sig=AOD64_0FVtDMC1oqiGztb3W1TkbtMHD5EQ&ctype=5&ved=0ahUKEwjXibzTg63XAhXl8YMKHQQzBAQQ2ikIEw&adurl=", 
:store_two=>"Drizly", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjHwb7Tg63XAhUBaH4KHbYYA4IYABADGgJwYw&sig=AOD64_2V1foxmYspQrCILNcAVpYA11DAFw&ctype=5&ved=0ahUKEwjXibzTg63XAhXl8YMKHQQzBAQQ2ikIFg&adurl=", 
:store_three=>"The Best Wine Store", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjHwb7Tg63XAhUBaH4KHbYYA4IYABAFGgJwYw&sig=AOD64_2c0I1TTRdBPB0o2qdE7YpUStTmzw&ctype=5&ved=0ahUKEwjXibzTg63XAhXl8YMKHQQzBAQQ2ikIGQ&adurl="}, 


  {:name=>"Faust Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Faust", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>55, :description=>"Faust is the epitome of the style that has made Napa Cabernet Sauvignon world renowned: bold and powerful, yet elegant and concentrated. Dense and inky, the core is a beautiful, rich ruby color. The aromas lift out of the glass with blackberry, black cherry, ripe raspberry and tea leaf. The entry is impressive with a fleshy mouthfeel and notes of cassis, dark chocolate and ripe berries. The layers continue to unfold throughout a long finish. ", :image_url=>"www.wine.com/labels/138305h.jpg", :expert_rating=>92.0, :professional_reviews=>"This is very intense with blackberries, dark chocolate, fresh mushrooms and blackcurrants. Full-bodied, fine and fruity yet complex and intense. Structured and lightly austere. Beautiful. Drink in 2020.", :user_rating=>4.3, :upc=>"0859369001254", :user_rating_count=>34, 

:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjJwtrTg63XAhWcuMAKHag5A-oYABABGgJpbQ&sig=AOD64_2fOOFG7VspuQoJrmkdnbGGydU74Q&ctype=5&ved=0ahUKEwjr6NjTg63XAhWB3oMKHeIwAOcQ2CkIJDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


  {:name=>"Opus One 2014", :varietal=>"Bordeaux Red Blends", :vintage=>2014, :producer=>"Opus One", :wine_type=>"Red Wine", :region=>"Oakville, Napa Valley, California", :country=>"US", :price=>315, :description=>"The 2014 Opus One exudes subtle aromas of fragrant florals, fresh garden herbs and forest floor that give way to a concentrated blend of red cherry, blackberry and black currant. Fine-grained tannins offer a velvety texture and complex structure that builds to a long, vibrantly fresh finish with a touch of mocha. Enjoyable now, the wine will delight for years to come.\nBlend: 80% Cabernet Sauvignon, 7% Petit Verdot, 6% Cabernet Franc, 5% Merlot, 2% Malbec", :image_url=>"www.wine.com/labels/342194h.jpg", :expert_rating=>94.33333333333333, :professional_reviews=>"Mesmerizing aromas of flowers, bark, currants and blackberries. So perfumed. You just want to smell it. Exquisite tension and finesse with an almost Burgundian texture, yet it’s Napa in its soul with ripe fruit, stones, spices and Chinese tea leaf flavors. Savory and delicious. Drinkable but better in 2020.", :user_rating=>4.2, :upc=>"0753604062140", :user_rating_count=>7, 

:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwj6r_HTg63XAhUDlH4KHUz-BccYABABGgJwYw&sig=AOD64_0LZvbel39tgoDS9uEcKF5klcZKUA&ctype=5&ved=0ahUKEwiT2O7Tg63XAhVD6IMKHZKmAlwQ2CkIKDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:name=>"Duckhorn Napa Valley Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Duckhorn Vineyards", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>75, :description=>"Complex and compelling, this generous wine reflects the diversity of great Napa Valley Cabernet Sauvignon. On the nose, vibrant layers of red and black fruit mingle with hints of violet, dried herbs, black licorice and graphite. The flavors echo the aromas, with lovely black currant and licorice elements supported by firm, impeccably balanced, tannins and an excellent structure. Good acidity helps to carry the juicy dark fruit notes through to a long, satisfying finish. Blend: 83% Cabernet Sauvignon, 13% Merlot, 2% Cabernet Franc, 2% Petit Verdot", :image_url=>"www.wine.com/labels/169807h.jpg", :expert_rating=>91.25, :professional_reviews=>"Duckhorn Vineyards produces one of America's most consistent and delicious Cabernet Sauvignons. The 2014 vintage is another excellent effort. This wine brings ripe cassis and licorice to the fore and combines those flavors with oak and vanilla nuances. Pair now with a juicy Porterhouse steak and savor. (Tasted: March 6, 2017, San Francisco, CA)", :user_rating=>4.1, :upc=>"066957601934", :user_rating_count=>37, 
:store_one=>"B-21 Florida", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwi7rLHUg63XAhUFa34KHQS7B4QYABABGgJwYw&sig=AOD64_0nk1oxga8PwGNoCqf7ZtHROPqDHw&ctype=5&ved=0ahUKEwjYxq7Ug63XAhVF7IMKHWjYC8UQ2ikIEQ&adurl=", 
:store_two=>"Wine.com", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwi7rLHUg63XAhUFa34KHQS7B4QYABADGgJwYw&sig=AOD64_3F_v75e_Xp3v3Xp1XDQlXYLLyTPA&ctype=5&ved=0ahUKEwjYxq7Ug63XAhVF7IMKHWjYC8UQ2ikIFA&adurl=", 
:store_three=>"Woodland Hills Wine Company", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwi7rLHUg63XAhUFa34KHQS7B4QYABAFGgJwYw&sig=AOD64_3gz2oX_1ZcOwzoo6680zl-MiHdkg&ctype=5&ved=0ahUKEwjYxq7Ug63XAhVF7IMKHWjYC8UQ2ikIFw&adurl="}, 


{:name=>"Meiomi Pinot Noir 2016", :varietal=>"Pinot Noir", :vintage=>2016, :producer=>"Meiomi", :wine_type=>"Red Wine", :region=>"California", :country=>"US", :price=>25, :description=>"A rich garnet color with a ruby edge, the wine opens to reveal lifted fruit aromas of bright strawberry and jammy fruit, mocha, and vanilla, along with toasty oak notes. Expressive boysenberry, blackberry, dark cherry, juicy strawberry, and toasty mocha ?avors lend complexity and depth on the palate. The well-integrated oak provides structure and depth seldom seen in Pinot Noir.", :image_url=>"www.wine.com/labels/215228h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.3, :upc=>"0855165005076", :user_rating_count=>161, 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjttOfUg63XAhXJl34KHcq4BzAYABABGgJwYw&sig=AOD64_1jkwF87tgthIK1wqU7sarUkq7EmQ&ctype=5&ved=0ahUKEwjy5uPUg63XAhUixYMKHYSiB-IQ2CkIIDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:name=>"Belle Glos Dairyman Vineyard Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Belle Glos", :wine_type=>"Red Wine", :region=>"Russian River, Sonoma County, California", :country=>"US", :price=>55, :description=>"Bright crimson red in color. Aromas of black cherry and ripe plums combine with subtle notes of dried herbs and smoke. The palate entry shows flavors of cranberry, fresh raspberry, and ripe cherry, complemented by hints of vanilla and baking spice. A balance of savory, cedar and cocoa powder, and sweet, fig jam and ripe blackberry, round out the mouth-feel. The overall impression is one of ripe red and black berry fruit flavors, great structure, smooth tannins and a lingering fresh finish.", :image_url=>"www.wine.com/labels/167772h.jpg", :expert_rating=>91.0, :professional_reviews=>"Delightfully rich and expressive, with tiers of dark blackberry, mocha, licorice and cherry. Broad and lingering on the deep and persistent finish.", :user_rating=>4.2, :upc=>"0855622000811", :user_rating_count=>17, 
:store_one=>"Wine.com", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjf1KzVg63XAhWRhmkKHe0vBDoYABABGgJpcQ&sig=AOD64_3Mm-NkZhB8vEmy3t6bZ90pBDldMg&ctype=5&ved=0ahUKEwiijKvVg63XAhVI7IMKHQUEANMQ2ikIDw&adurl=", 
:store_two=>"B-21 Florida", :link_two=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjf1KzVg63XAhWRhmkKHe0vBDoYABADGgJpcQ&sig=AOD64_1BNwKyz11LKOwOWEm7VXlOdJwXPA&ctype=5&ved=0ahUKEwiijKvVg63XAhVI7IMKHQUEANMQ2ikIEg&adurl=", 
:store_three=>"Grapeswine.com", :link_three=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjf1KzVg63XAhWRhmkKHe0vBDoYABAFGgJpcQ&sig=AOD64_1s08zx_opXXgwtj-bWiNzcclH4jw&ctype=5&ved=0ahUKEwiijKvVg63XAhVI7IMKHQUEANMQ2ikIFQ&adurl="}, 


{:name=>"Saintsbury Carneros Pinot Noir 2014", :varietal=>"Pinot Noir", :vintage=>2014, :producer=>"Saintsbury", :wine_type=>"Red Wine", :region=>"Carneros, California", :country=>"US", :price=>36, :description=>"Pretty, dense aromas of rose petal, dark cherries, cocoa, anise, and cardamom. Sweet cherry and plum entry with a zesty mid palate reminiscent of baking spices, leading into an opulent, elegant, lingering finish. \nThe richness of this wine pairs well with fatty, rich meats, such as lamb, duck, and stewed curries, as well as artisanal cheeses and wild mushrooms.", :image_url=>"www.wine.com/labels/175396h.jpg", :expert_rating=>90.5, :professional_reviews=>"I am often perplexed when I taste and evaluate Pinot Noir—there are no real prototypes of this grape variety. The wines' nuances run the gamut from tart red to very deep black fruits. In the end, one must go with the hedonistic approach and just let each individual wine reveal itself. The 2014 Saintsbury Pinot Noir does an excellent job of showing off its Napa Carneros roots—ripe fruits that run between red and black, textures that are rather substantial, and herbs that show just an accent of savoriness.", :user_rating=>3.0, :upc=>"0732458950773", :user_rating_count=>2, 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjfotPVg63XAhWCt8AKHT0IC_gYABABGgJpbQ&sig=AOD64_0yC7I5LCQi7aouCi9BuP1yScyIKg&ctype=5&ved=0ahUKEwiZn9HVg63XAhXq7YMKHeoOBj8Q2CkIJDAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:name=>"Banshee Sonoma County Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Banshee", :wine_type=>"Red Wine", :region=>"Sonoma County, California", :country=>"US", :price=>28, :description=>"This wine leads with a bouquet of red fruits and cherry blossom aromas. The silky palate is layered with notes of cherry, hibiscus, mandarin peel and a faint coppery counterpoint to the fruit. In addition, one might find a hint of dark plum. The finish is fine-boned and harmonious.", :image_url=>"www.wine.com/labels/237120h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.4, :upc=>"0853868006024", :user_rating_count=>5, 
:store_one=>"Link to Buy", :link_one=>"http://www.google.com/aclk?sa=l&ai=DChcSEwjY3-vVg63XAhVBlH4KHTIgCvsYABABGgJwYw&sig=AOD64_1RWy6bHR-qdFGqH9LwW5oFC-YIKQ&ctype=5&ved=0ahUKEwi_1ejVg63XAhUr7IMKHSdsD34Q2CkIGTAA&adurl=", 
:store_two=>nil, :link_two=>nil, 
:store_three=>nil, :link_three=>nil}, 


{:name=>"Bread & Butter Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Bread & Butter", :wine_type=>"Red Wine", :region=>"California", :country=>"US", :price=>16, :description=>"This Pinot Noir is all about that juicy red fruit. Think cherries and raspberries with a touch of cassis. Delicate hints of cedar, smoke, and bay leaf cut the sweetness of the fruit, creating a nicely balanced bouquet.That luscious fruit bouquet continues onto the palate, where it’s joined by soft flavors of wood and cured meat, like bacon. With a long and beautifully smooth finish, this Pinot will melt in your mouth. ", :image_url=>"www.wine.com/labels/218385h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.1, :upc=>"0850832004277", :user_rating_count=>8, 
:store_one=>"B-21 Florida", :link_one=>"https://www.b-21.com/2015-Bread-Butter-Pinot-Noir/productinfo/USBBPN15AE/?CAWELAID=120175640000406568&CAGPSPN=pla&CAAGID=19984782492&CATCI=pla-328467903746&CATARGETID=120175640000407265&cadevice=c&gclid=EAIaIQobChMIqdH394Wt1wIVSbjACh1pjw62EAkYASABEgK0GfD_BwE", 
:store_two=>nil, :link_two=> nil, 
:store_three=>nil, :link_three=>nil}]
