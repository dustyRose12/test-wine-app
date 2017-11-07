# Country.create!([
#                           {name: "Germany"},
#                           {name: "France"},
#                           {name: "US"},
#                           {name: "Italy"},
#                           {name: "Spain"},
#                           {name: "Chile"}
#                           ])

# Region.create!([
#                       {name: "Mosel", country_id: 1},
#                       {name: "Alsace", country_id: 2},
#                       {name: "Sonoma", country_id: 3},
#                       {name: "Napa", country_id: 3},
#                       {name: "Tuscany", country_id: 4},
#                       {name: "Rioja", country_id: 5},
#                       {name: "Colchagua Valley", country_id: 6},
#                       {name: "Champagne", country_id: 2},
#                       {name: "Priorat", country_id: 5}
#                       ])

# Producer.create!([
#                             {name: "Fritz Haag"},
#                             {name: "Jean-Baptiste Adam"},
#                             {name: "Failla"},
#                             {name: "Alpha Omega"},
#                             {name: "Williams Selyem"},
#                             {name: "Baricci"},
#                             {name: "Bodegas Roda"},
#                             {name: "Lapostolle"},
#                             {name: "Louis Roederer"},
#                             {name: "Terroir Al Límit"}
#                             ])

# Varietal.create!([
#                         {name: "Riesling", wine_type: "White"},
#                         {name: "Chardonnay", wine_type: "White"},
#                         {name: "Cabernet Sauvignon", wine_type: "Red"},
#                         {name: "Pinot Noir", wine_type: "Red"},
#                         {name: "Sangiovese", wine_type: "Red"},
#                         {name: "Tempranillo", wine_type: "Red"},
#                         {name: "Red Blend", wine_type: "Red"},
#                         {name: "Champagne", wine_type: "Sparkling"},
#                         {name: "Rosé", wine_type: "Rosé"}
#                         ])

# # Category.create!([
# #                           {name: "bla bla"}
# #                           ])

# Wine.create!([
#                       {producer_id: 1, name: "Brauneberger Kabinett", varietal_id: 1, vintage: 2014, region_id: 1, price: 32, expert_rating: 93, alcohol: "8%", ml: 750, description: "Irresistably juicy and fruity, yet so delicately nuanced by spice, earth and mineral, this light-footed kabinett encapsulates much of what's so special about Mosel Riesling. The palate bursts with rich yellow peach and mango, but nervous lemon-lime acidity lends an electric vibe. It's delicious now but should improve through 2021."},

#                        {producer_id: 2, name: "Letzenberg", varietal_id: 1, vintage: 2015, region_id: 2, price: 36, expert_rating: 94, alcohol: "13%", ml: 750, description: "Intense lemon and tangerine notes create a most inviting nose. The palate continues in full tangy mode: the aromatic zest of tangerine and ripe Amalfi lemon create a concentrated, uplifting and even cooling freshness. The body is slender but totally concentrated with a dynamic linear structure. Over time, riper notes of honeyed stone fruit appear despite the very dry style, but the chief charms are a marvel of citrus diversity. Drink now through 2035."},

#                          {producer_id: 3, name: "Estate Vineyard", varietal_id: 2, vintage: 2010, region_id: 3, price: 44, expert_rating: 99, alcohol: "14.2%", ml: 750, description: "Shows classic, full-throttle notes of tropical and citrus fruits, pears and sweet green apples, combined with strong minerality and complex layers of buttered toast, honey and creamy lees. The description alone hardly does justice to the wine's beauty. The acidity is perfect, the oak deftly applied, the finish long and completely satisfying."},

#                          {producer_id: 4, name: "Beckstoffer Georges III", varietal_id: 3, vintage: 2009, region_id: 4, price: 250, expert_rating: 97, alcohol: "14.9%", ml: 750, description: "This 100% varietal and barrel-fermented wine is a remarkable study in power and grace. Black cherry, cigar box and cedar bark flavors and an invitingly sweet sensation of tannin are supported by bright, lingering acidity and supple complexity."},

#                           {producer_id: 5, name: "Coastlands Vineyard", varietal_id: 4, vintage: 2014, region_id: 3, price: 75, expert_rating: 98, alcohol: "13.3%", ml: 750, description: "Pretty as all get-out, this wine is a floral masterpiece—a study in coastal rose and forest scents with a counterpunch of white pepper that leaves one wanting more. Juicy raspberry, strawberry and tangerine flavors are seasoned in allspice and tobacco, the palate so beautifully delicate yet fully realized in savory complexity and length."},

#                           {producer_id: 6, name: "Nello Riserva", varietal_id: 5, vintage: 2010, region_id: 5, price: 120, expert_rating: 98, alcohol: "14.5%", ml: 750, description: "New leather, mature black-skinned fruit, tilled soil and a touch of dark spice are some of the aromas you'll find on this fantastic, full-bodied red. The big, velvety palate shows power and finesse, offering mouthfuls of juicy wild cherry, black raspberry, licorice, Mediterranean herb and a note of exotic spice framed in firm, ripe tannins. It's already balanced and delicious, but hold for more complexity. Drink 2020–2035."},

#                            {producer_id: 7, name: "Cirsion", varietal_id: 6, vintage: 2009, region_id: 6, price: 250, expert_rating: 97, alcohol: "14.5%", ml: 750, description: "Solid as a battleship, with lemony oak, marzipan and layer upon layer of black fruit aromas. Almost syrupy in its richness but not fully; it's chewy and creamy, with vital acids. The flavors are mega ripe and rich, emphasizing blackberry, black cherry preserves, fudge and fig paste. Yet at the same time it's an ethereal wine; the epitome of modern Rioja."},

#                             {producer_id: 8, name: "Clos Apalta", varietal_id: 7, vintage: 2011, region_id: 7, price: 110, expert_rating: 95, alcohol: "14.2%", ml: 750, description: "Cool aromas of cola, coffee, blackberry, stewed plum, herbs and minerals make for a highly attractive and complex bouquet. In the mouth, wall-to-wall power and tannins suggest that this needs a few more years to mellow out. Flavors of stewed plum, blackberry, Carolina barbecue sauce and a hint of citrus peel are complex and set up a deep finish with dark flavors and intensity to spare. Drink from 2016 through 2025. The blend is 57% Carmenère, 34% Cabernet Sauvignon and 9% Merlot."},

#                               {producer_id: 9, name: "Cristal Brut", varietal_id: 8, vintage: 2009, region_id: 8, price: 249, expert_rating: 97, alcohol: "12%", ml: 750, description: "The latest incarnation of this famous Champagne now comes from Roderer's own vineyards, a good portion of which are run on biodynamic lines. This still-young wine has great depth and richness, a beautiful balance between ripe fruit and crisp texture that make it alive, crisp and bright. As it matures, it will deepen and become even more intense. Drink now if you must, but preferably wait until 2019."},
                              
#                               {producer_id: 10, name: "Roc d'Aubaga", varietal_id: 9, vintage: 2016, region_id: 9, price: 50, expert_rating: 92, alcohol: "13.5%", ml: 750, description: "Like an ugly duckling that's a beautiful swan in waiting, this unique rosé, if you can call it that given its rusty, almost brown color, is something only Terroir Al Limít would bottle. Earthy in aromas, this mix of several Grenache strains tastes of apricot and dried red fruits. It's mildly spicy throughout, with actual tannins from skin contact. Drink this quasi rosé as you would a serious white or red, meaning with good food like a Catalan-style rice dish. And drink now."}                 
#                       ])

# # Create Categories later
# # CategoryWine.create!([
# #                                   {wine_id: 10, category_id:10}
# #                                   ])

# Image.create!([
#                         {wine_id: 1, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/234352_117be_jun16_3660.jpg"},
#                         {wine_id: 2, url: "http://www.thesortingtable.com/wp-content/uploads/2015/07/Jean-Baptiste_Riesling-Letzenberg-300-dpi-700x1024.jpg"},
#                         {wine_id: 3, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/152203_WEB1_JULY12_3017.jpg"},
#                         {wine_id: 4, url: "https://wine-searcher1.freetls.fastly.net/images/labels/28/78/alpha-omega-beckstoffer-georges-iii-cabernet-sauvignon-rutherford-usa-10402878.jpg"},
#                         {wine_id: 5, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/255737_94be_apr17_3760.jpg"},
#                         {wine_id: 6, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/233171_36be_dectopcs16_3720.jpg"},
#                         {wine_id: 7, url: "http://roda.es/typo3temp/pics/7a8bd2dbb5.jpg"},
#                         {wine_id: 8, url: "https://wine-searcher1.freetls.fastly.net/images/labels/94/96/casa-lapostolle-clos-apalta-colchagua-valley-chile-10209496.jpg"},
#                         {wine_id: 9, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/249693_38be_dec16_3720.jpg"},
#                         {wine_id: 10, url: "https://www.mwcwine.com/images/sites/mwcwine/labels/w2314902of_1.jpg"}
#                         ])

# Deleted this, did it through the signup page instead
# User.create!([
#                     {name: "Rocio Cifrian", email: "rocio87@gmail.com", password_digest: "password", username: "rocio87", profile_pic: "http://www.theworldwidewine.com/Wine_reviews/Weekly_cheap_wine_reviews/Section2/mosel_castle_in_tasting_cheap_wine.jpg"}
#                     ])


# ==========================================================
# new seed test batch:

# wines = 
# [{:name=>"Peter Michael Point Rouge Chardonnay 2014", :varietal=>"Chardonnay", :vintage=>2014, :producer=>"Peter Michael", :wine_type=>"White Wine", :region=>"Sonoma, California", :country=>"US", :price=>499, :description=>"Elegant, complex and rich, the 2014 Point Rouge is an exceptional wine. The nose is filled with aromas of vine blossom, ripe apple, citrus oils, orange rind, William pear, almond and acacia honey. Seamless and rich in the mouth, notes of mangosteen, green gage, crème brûlée, honeysuckle, vanilla, spice cake and white truffle are framed with an oyster shell minerality. The wine offers a rare harmony as well as extraordinary tactile persistence. Already refined, the wine will gain even more complexity in 4-5 years and should continue to age gracefully for two decades.", :image_url=>"www.wine.com/labels/166067h.jpg", :expert_rating=>97.0, :professional_reviews=>"One of two wines flirting with perfection (much like the 2012 has already achieved), the 2014 Chardonnay Point Rouge (275 cases in this vintage vs. 165 in 2013) is usually a selection by Nic Morlet and his brother Luc of the finest barrels in the cellar. Much of it comes from the old vines of Belle Côte. The 2014 comes across like a great Bâtard-Montrachet, with buttery apple notes intermixed with white peach, orange marmalade, caramelized citrus, great acid, full-bodied power, and a stunningly long finish of almost 45 seconds. It is often one of the three or four finest Chardonnays made in the world, and appears to be so in 2014. Drink it over the next decade, although they tend to last even longer. (The 2001 I just tasted was amazing.)", :user_rating=>3.5, :user_rating_count=>3}, 

#   {:name=>"Peter Michael Ma Danseuse Pinot Noir 2014", :varietal=>"Pinot Noir", :vintage=>2014, :producer=>"Peter Michael", :wine_type=>"Red Wine", :region=>"Sonoma, California", :country=>"US", :price=>nil, :description=>"This wine charms the eye with a red ruby color and bright crimson highlights. The nose is marked with notes of rose, raspberry, Griotte cherry, strawberry and forest floor. Delicate, fragrant, complete and refined, on the palate the 2014 Ma Danseuse has a wonderful concentration of red fruit and rose blossom, with subtle savory notes of sandalwood, leather, clove, hazelnut, mineral and cigar box, which embraces a silky texture and lingering aromatic finish. It will continue to express its potential for two decades.", :image_url=>"www.wine.com/labels/166068h.jpg", :expert_rating=>96.5, :professional_reviews=>"Wonderful perfumes with blackberry, cherry and cloves. Violet. Full body, extremely focused and clear fruit. Bright and vivid. Crunchy and juicy. Precise and fruity. Love the layers and flavors. Irresistible.", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Quilceda Creek Palengat Vineyard Red Blend 2013", :varietal=>"Bordeaux Red Blends", :vintage=>2013, :producer=>"Quilceda Creek Vintners", :wine_type=>"Red Wine", :region=>"Columbia Valley, Washington", :country=>"US", :price=>149, :description=>"The 2013 Quilceda Creek Palengat Proprietary Red Wine was sourced from Champoux, Palengat, Lake Wallula and Wallula Gap Vineyards which are located in the Horse Heaven Hills AVA. This exotic Merlot-based wine displays beautiful layers of aromatic plum and black cherry fruit with nuances of anise, soy, graphite and minerals. It has stunning purity and delineation, with superfine tannins. Aged in 100% new French oak for 20 months. Blend: 58% Merlot, 30% Cabernet Sauvignon, and 12% Cabernet Franc ", :image_url=>"www.wine.com/labels/166069h.jpg", :expert_rating=>94.0, :professional_reviews=>"More Merlot dominated in 2013 (they plan to move this back to a more Cabernet Sauvignon dominated blend in the future), the 2013 Palengat Vineyard is another terrific 2013 that makes the most of vintage. Sexy, voluptuous and rounded, with no hard edges, it gives up classic notes of plums, graphite and licorice in its full-bodied, mouth-filling and impossible to resist style. While I’d happily drink a glass (or three) today, it will drink well for another 10-15 years.", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Quilceda Creek Galitzine Vineyard Cabernet Sauvignon 2013", :varietal=>"Cabernet Sauvignon", :vintage=>2013, :producer=>"Quilceda Creek Vintners", :wine_type=>"Red Wine", :region=>"Columbia Valley, Washington", :country=>"US", :price=>194, :description=>"The 2013 Quilceda Creek Galitzine Vineyard Cabernet Sauvignon is from the Red Mountain AVA. The 2013 is an awesome wine that displays rich, complex aromas and flavors of classic blackberry and cassis fruit, sweet pipe tobacco, forest floor, and minerals. Aged in 100% new French Oak for 20 months, it is 95% Cabernet Sauvignon from Galitzine Vineyard and 5% Cabernet Sauvignon from Wallula Gap Vineyard.", :image_url=>"www.wine.com/labels/166070h.jpg", :expert_rating=>96.0, :professional_reviews=>"An utterly prodigious effort that would most likely be the wine of the vintage if not for its big brother, the 2013 Cabernet Sauvignon Galitzine Vineyard comes all from Red Mountain and was raised in 100% new French oak. Revealing a healthy ruby/purple color and classic notes of sage brush, graphite, black cherries, currants and chocolate, it hits the palate with full-bodied richness; building, present, yet ripe and polished tannin; perfect integration of its fruit, alcohol and oak; and awesome length. This is a powerhouse Cabernet Sauvignon that still holds onto a sense of elegance and finesse. Forget it for 4-5 years and drink bottles over the following two decades.", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Banfi Brunello di Montalcino (1.5 Liter Magnum) 2010", :varietal=>"Sangiovese", :vintage=>2010, :producer=>"Castello Banfi", :wine_type=>"Red Wine", :region=>"Montalcino, Tuscany", :country=>"Italy", :price=>nil, :description=>"Intense ruby red in color with garnet reflections. Aromas of violets and vanilla, with hints of licorice. Velvety palate, with tart-cherry flavors and traces of spice. Well structured with supple tannins, superb concentration, and good acidity. Persistent finish.", :image_url=>"www.wine.com/labels/166071h.jpg", :expert_rating=>92.2, :professional_reviews=>"Fabulous aromas of dried rose petal, orange peel, oyster shell and hints of dark fruits. Full body, very fine tannins with a mineral, berry and orange-peel and Tuscan-dust undertone. A structured, salty, savory finish. Better in 2017.", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Uvaggio Passito Vermentino (500ML)", :varietal=>"Other Dessert", :vintage=>0, :producer=>"Uvaggio", :wine_type=>"Sparkling & Champagne", :region=>"Lodi, California", :country=>"US", :price=>21, :description=>"From Liguria in Italy’s north, south to the island of Pantelleria (between Sicily and Tunisia) unique Passito wines are made from dried grapes, as they have been for centuries, since the era of the Phoenicians.The dried fruit was pressed, yielding only about half the juice as is normal. It was filled to barrels allowing the native yeasts to slowly ferment, after which it was aged for almost a year. The golden yellow color is a result of not using any SO2 until bottling.  ", :image_url=>"www.wine.com/labels/166072h.jpg", :expert_rating=>92.0, :professional_reviews=>"Full body and powerfully fruity flavors make this sweet wine seem extra bold. It smells like toasted almonds and dried meat and tastes like poached peaches. A smooth but lively texture keeps the flavors zinging on the finish.Editors' Choice", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Patricia Green Reserve Pinot Noir 2015", :varietal=>"Pinot Noir", :vintage=>2015, :producer=>"Patricia Green", :wine_type=>"Red Wine", :region=>"Willamette Valley, Oregon", :country=>"US", :price=>24, :description=>"This wine is a smoking deal! We work with 8 Pinot Noir vineyards, all of which we make at least one vineyard designated bottling from, and this bottling simply takes the barrels that are more precocious or don’t fit in with the profile of the vineyard designated bottling. 75% of this comes from Ribbon Ridge and Chehalem Mountains AVAs, 15% comes from the Dundee Hills AV and the rest, while designated Willamette Valley AVA is all from Freedom Hill Vineyard. There are seriously great bones here and this wine will stand up to many, many much higher priced bottlings.", :image_url=>"www.wine.com/labels/166073h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.8, :user_rating_count=>2}, 

#   {:name=>"El Enemigo Mendoza Gran Enemigo 2010", :varietal=>"Other Red Blends", :vintage=>2010, :producer=>"El Enemigo", :wine_type=>"Red Wine", :region=>"Mendoza", :country=>"Argentina", :price=>90, :description=>"The nose presents sweet aromas of black ripen fruits with hints of vanilla and chocolate, which appear after the oak ageing. The mouthfeel is sweet with structured, persistent tannins due to the natural acidity of this wine, leading into an excellent long finish. This wine pairs well with grilled meat, cheese, or slow roasted beef dishes.", :image_url=>"www.wine.com/labels/166074h.jpg", :expert_rating=>95.0, :professional_reviews=>"A wonderful red with complex aromas and flavors of blackberry, mineral, stone and earth. Full body, pure fruit and great beauty. Incredible layers and subtlety. Drink now. A blend of cabernet franc, petit verdot, cabernet sauvignon and merlot, aged 13 to 24 months in large 100-year-old Gamba casks. Wow.", :user_rating=>4.2, :user_rating_count=>2}, 

#   {:name=>"Gregory Graham Magma Red 2012", :varietal=>"Bordeaux Red Blends", :vintage=>2012, :producer=>"Gregory Graham", :wine_type=>"Red Wine", :region=>"North Coast, California", :country=>"US", :price=>27, :description=>"The wine exhibits aromas of ripe plum and chocolate/mocha, with highlights of mint and dried herbs. The lively concentrated flavor bursts with ripe berries and sweet oak. This structured wine is best enjoyed with slow cooked ribs or stews.", :image_url=>"www.wine.com/labels/166075h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>0.0, :user_rating_count=>0}, 

#   {:name=>"Joseph Drouhin Gevrey-Chambertin 2014", :varietal=>"Pinot Noir", :vintage=>2014, :producer=>"Joseph Drouhin", :wine_type=>"Red Wine", :region=>"Cote d'Or, Burgundy", :country=>"France", :price=>nil, :description=>"Gevrey-Chambertin is a wine with a beautiful, bright ruby color. Intensely fruity on the nose, the aromas are reminiscent of black cherry, wild blackberry and licorice. The woody character is subtle and marries delicately with the other aromas. As the wine evolves, there are more complex notes, such as mild spice, nutmeg and leather. Later still, mushroom and damp earth nuances make their appearance. Although present on the palate, tannin is never astringent but blends itself harmoniously with the natural freshness and 'gras' (velvety texture) of the wine. The same aromas encountered earlier on the nose are found again in the aftertaste.", :image_url=>"www.wine.com/labels/166076h.jpg", :expert_rating=>92.0, :professional_reviews=>"Rich and inviting, featuring cherry, strawberry and spice flavors that remain persistent through the finish. Balanced, with civilized tannins and excellent length. Best from 2019 through 2032. 700 cases imported.", :user_rating=>2.5, :user_rating_count=>1}]

#2nd test batch to test sherry, port, madeira, dessert:

# wines = [

# {:name=>"Emilio Hidalgo La Panesa Especial Fino Sherry", :varietal=>"Sherry", :vintage=>0, :producer=>"Emilio Hidalgo", :wine_type=>"Sparkling & Champagne", :region=>"Jerez", :country=>"Spain", :price=>64, :description=>"All finos develop under the veil of flor and this is evident on the nose of this wine, showing its bready, yeasty character.  This Especial shows typical hints of yeast, but is fuller and rounder on the palate than the regular Panesa bottling. \nThis wine can stand up to fuller-flavored dishes such as salmon a la plancha, sesame-seared ahi tuna, or gazpacho.", :image_url=>"www.wine.com/labels/165564h.jpg", :expert_rating=>92.7, :professional_reviews=>"“Fino Amontillado” is a style of Sherry that’s virtually extinct. It was made from old wines that had almost lost their flor and had begun to oxidize, their color darkening as they gained depth and complexity. Although La Panesa is not, strictly speaking, a Fino Amontillado, it has the characteristics of those wines from the past. With an average of 15 years of aging in solera (ten more than most Finos), it takes the lifespan of flor to the limit, creating a wine that’s intoxicating in its mineral and dried-fruit fragrance. Bone dry, saline flavors drive the wine from beginning to end, their abundance leaving no room for sweetness. This is the definition of verticality and elegance.", :user_rating=>0.0, :user_rating_count=>0}, 

# {:name=>"Emilio Hidalgo Villapanes Oloroso Seco Sherry", :varietal=>"Sherry", :vintage=>0, :producer=>"Emilio Hidalgo", :wine_type=>"Sparkling & Champagne", :region=>"Jerez", :country=>"Spain", :price=>75, :description=>"Villapanes is a rich mahogany color and boasts seductive, toasty aromas of almonds, caramel, fig and a hint of floral perfume. On the palate it is dry, generous and full-bodied, with persistent and lasting flavors.\nPair with roast poultry, red meat or salty, aged cheeses.", :image_url=>"www.wine.com/labels/165565h.jpg", :expert_rating=>90.8, :professional_reviews=>"The NV Villapanes Oloroso wears a dark amber-brown robe and has a very intense nose, showing some marmalade, dark tobacco and brandy notes. The palate is textbook Oloroso, round, ample, warm, a little spirity, ending with dry walnut flavors. It manages to balance power and elegance quite well.", :user_rating=>3.0, :user_rating_count=>1}, 

# {:name=>"Flora Springs Napa Valley Sauvignon Blanc 2015", :varietal=>"Sauvignon Blanc", :vintage=>2015, :producer=>"Flora Springs", :wine_type=>"White Wine", :region=>"Napa Valley, California", :country=>"US", :price=>nil, :description=>"The 2015 Sauvignon Blanc offers bright fruit flavors of grapefruit, passion fruit and mandarin orange with subtle floral notes of honeysuckle and orange blossom. The wine has a broad, creamy mid-palate with perfumed notes of lychee nut and Asian pear, and there’s a slightly nutty quality that adds to the complexity. The finish is spicy and mineral-laced, bringing the wine to a mouthwatering close.", :image_url=>"www.wine.com/labels/165566h.jpg", :expert_rating=>90.0, :professional_reviews=>"The melon, peach and apricot flavors are ripe and fleshy, with ginger and lemon meringue accents set on a creamy texture. Refreshing acidity emerges on the finish.", :user_rating=>3.8, :user_rating_count=>2}, 

# {:name=>"Emilio Hidalgo Pedro Ximenez (500ML)", :varietal=>"Sherry", :vintage=>0, :producer=>"Emilio Hidalgo", :wine_type=>"Sparkling & Champagne", :region=>"Jerez", :country=>"Spain", :price=>21, :description=>"Aromas of maple, raisins and chocolate make this the ultimate after-dinner drink. Rich, sweet and mouth-filling yet true to the elegant, refined style that marks all Hidalgo wines.\nDrink with blue veined cheeses and experience a classic pairing.", :image_url=>"www.wine.com/labels/165567h.jpg", :expert_rating=>92.0, :professional_reviews=>"This has good cut driving the caramel, butterscotch, raisin and orange peel flavors. There's a slight burnt edge, but overall this is beautifully balanced and melts in the mouth.", :user_rating=>0.0, :user_rating_count=>0}, 

# {:name=>"Uppercut Napa Valley Cabernet Sauvignon 2014", :varietal=>"Cabernet Sauvignon", :vintage=>2014, :producer=>"Uppercut ", :wine_type=>"Red Wine", :region=>"Napa Valley, California", :country=>"US", :price=>nil, :description=>"Broad shouldered and muscular, yet food friendly and approachable, the 2014 Uppercut Cabernet Sauvignon makes the perfect match for a sizzling steak. The wine's generous black cherry and blackberry aromas and flavors draw you in and then, with each swirl and sip, reveal complex hints of mocha, anise, tamari and mineral, plus a racy hint of smokiness. Well-structured tannins give this wine the backbone to stand up to boldly flavored foods, as well as a plush texture that carries the rich dark-fruit flavors through the lingering finish. This wine's multilayered personality is unmistakably Napa Valley Cab.Blend: 88% Cabernet Sauvignon, 6% Merlot, 4% Cab Franc, 2% Malbec", :image_url=>"www.wine.com/labels/165568h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>4.5, :user_rating_count=>2}, 

# {:name=>"Emilio Hidalgo Fino Sherry", :varietal=>"Sherry", :vintage=>0, :producer=>"Emilio Hidalgo", :wine_type=>"Sparkling & Champagne", :region=>"Jerez", :country=>"Spain", :price=>14, :description=>"All Finos develop under the veil of flor and this is evident on the nose of this wine, showing its bready, yeasty character.  Opening with typical notes of green olives, this refreshing fino gives way to delicate wildflowers on the nose.\nPairs perfectly with classic tapas but can also last the whole meal through with seafood and even sushi. This wine is meant to be served very-well chilled and can be used an aperitif as well as the most refreshing accompaniment to many classic, simple sea", :image_url=>"www.wine.com/labels/165569h.jpg", :expert_rating=>90.0, :professional_reviews=>"Sea salt, Brazil nut and dried chamomile notes are racy and filigreed, with a stony edge on the finish.", :user_rating=>0.0, :user_rating_count=>0}, 

# {:name=>"Emilio Hidalgo Morenita Cream Sherry", :varietal=>"Sherry", :vintage=>0, :producer=>"Emilio Hidalgo", :wine_type=>"Sparkling & Champagne", :region=>"Jerez", :country=>"Spain", :price=>14, :description=>"This is a delicate style cream with hints of caramel, dried fruits and mocha on the nose. Smooth and elegant with well-balanced sweetness, it still manages to be refreshing.\nServe slightly chilled or on the rocks as an aperitif or enjoy with mildly rich meals.", :image_url=>"www.wine.com/labels/165570h.jpg", :expert_rating=>90.5, :professional_reviews=>"This is bright for a cream Sherry, with green tea and singed ginger notes out front, providing heft to the date, raisin, caramel and charred bourbon barrel accents. The sleek finish lets the green tea edge reemerge, with well-embedded acidity for length.", :user_rating=>4.5, :user_rating_count=>1}, 

# {:name=>"Bodegas Volver Tarima Hill 2014", :varietal=>"Mourvedre", :vintage=>2014, :producer=>"Bodegas Volver", :wine_type=>"Red Wine", :region=>"", :country=>"Spain", :price=>17, :description=>"The wine exhibits deep garnet color with flashes of violet and a bouquet of dark red cherries and leather. On the palate the wine achieves its full potential, offering notes of black berries, plums and licorice with an elegant but persistent finish.", :image_url=>"www.wine.com/labels/165571h.jpg", :expert_rating=>92.0, :professional_reviews=>"Lastly, the 2014 Tarima Hill, from Alicante, is also 100% Mourvèdre aged 20 months in French oak and from the oldest vines of the estate, planted 1935-1975. They are also relatively high elevation, at 2,000 to 2,400 feet above sea level. This wine shows wonderful, pure aromatics of blueberry, black raspberries, chalk and spring flowers. The wine has beautiful, full-bodied texture, impressive ripeness and purity and length. The minerality is present, and the wine a heck of a value.", :user_rating=>3.6, :user_rating_count=>7}, 

# {:name=>"Quinta de Chocapalha Arinto 2015", :varietal=>"Other White Wine", :vintage=>2015, :producer=>"Quinta de Chocapalha", :wine_type=>"White Wine", :region=>"", :country=>"Portugal", :price=>nil, :description=>"Bright lemon yellow in color with a freshly aromatic nose of citrus and tropical fruits, Quinta de Chocapalha Arinto boasts lively acidity and a lingering finish. Pairs well with fresh salads, grilled white fish, and roasted chicken.", :image_url=>"www.wine.com/labels/165572h.jpg", :expert_rating=>91.0, :professional_reviews=>"The 2015 Arinto, aged on the lees but unoaked, is sourced from the winery's oldest vines. This has always been a wine I've liked. This may be their best one ever, which should make it a super bargain. Precise, rather powerful and showing fine grip on the finish, this has both character and structure, everything in a well balanced whole. If you like them crisp, pointed and fresh, you can't go wrong at this price. In fact, back up the truck.", :user_rating=>4.5, :user_rating_count=>6}, 

# {:name=>"Kalex Pinot Noir 2013", :varietal=>"Pinot Noir", :vintage=>2013, :producer=>"Kalex", :wine_type=>"Red Wine", :region=>"Central Otago", :country=>"New Zealand", :price=>38, :description=>"Rose Petals, smoke & red fruits dominate the aromas of this textural, layered Pinot Noir. The palate is silky, savory, and seductive  – spice & lifted red fruits.", :image_url=>"www.wine.com/labels/165573h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>0.0, :user_rating_count=>0}

# ]

# wines = 
# [
#   {:name=>"Clean Slate Riesling 2015", :varietal=>"Riesling", :vintage=>2015, :producer=>"Clean Slate", :wine_type=>"White Wine", :region=>"Mosel", :country=>"Germany", :price=>10, :description=>"Ripe peach flavors balance ripe acidity, hints of lime and characteristic mineral notes and hints of spice. Pairs beautifully with spicy cuisines, Asian, Tex-Mex, Indian, and sushi.", :image_url=>"www.wine.com/labels/159864h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>3.8, :user_rating_count=>13},


# {:name=>"Goretti Montefalco Rosso 2010", :varietal=>"Other Red Blends", :vintage=>2010, :producer=>"Goretti", :wine_type=>"Red Wine", :region=>"Veneto", :country=>"Italy", :price=>nil, :description=>"The passion of the Goretti winery has been fundamental in a family history of wine making spanning generations, and it exists today as the family continues its participation in the Italian world of viticulture with pride, passion and exceptionally consistent quality. This bold red wine blend of Sangiovese coupled with Merlot and the Umbrian grape Sagrantino is underlined by a beautiful ruby red color with good luminosity. Very intense bouquet with a clean and delicate fragrance. A marked presence of mature berry-fruit such as blackberries together with spiced floral notes. Expresses an overwhelming pleasantness, warm and austere, with perfect harmony. Blend: 60% Sangiovese, 20% Merlot, 20% Sagrantino", :image_url=>"www.wine.com/labels/139450h.jpg", :expert_rating=>nil, :professional_reviews=>"N/A", :user_rating=>0.0, :user_rating_count=>0},

# {:name=>"Apothic Red Blend 2015", :varietal=>"Other Red Blends", :vintage=>2015, :producer=>"Apothic", :wine_type=>"Red Wine", :region=>"California", :country=>"US", :price=>16, :description=>"A bold blend of primarily Zinfandel, Syrah, Merlot, and Cabernet Sauvignon, Apothic Red leaves a lasting impression of flavor and texture on the palate. Zinfandel offers bold dark fruit flavors and spicy notes, complemented by the soft mouthfeel of Merlot. The Syrah adds layers of smooth blueberry, while the Cabernet Sauvignon delivers ripe fruit flavors and a firm structure. This decadent blend is framed by hints of black cherry, vanilla, and mocha. ", :image_url=>"www.wine.com/labels/178214h.jpg", :expert_rating=>88.0, :professional_reviews=>"A crowd-pleasing wine, the 2015 Apothic Red Winemaker's Blend is an easy-drinker. Blended with Zinfandel, Syrah, Cabernet Sauvignon, and Merlot, this up-front wine works well with lightly grilled foods as well as mildly spicy appetizers. (Tasted: May 3, 2017, San Francisco, CA)", :user_rating=>3.9, :user_rating_count=>64}
# ]

# wines = paste new wines hash here

wines.each do |wine_hash|
    country = Country.find_or_create_by({name: wine_hash[:country]}) 

    region = Region.find_or_create_by({
                                                            name: wine_hash[:region], 
                                                            country_id: country.id 
                                                            })

    producer = Producer.find_or_create_by({name: wine_hash[:producer]})

    
    winetype = wine_hash[:wine_type]
    varietal_from_hash = wine_hash[:varietal]

    if winetype == "White Wine"
      winetype = "White"
    elsif winetype == "Red Wine"
      winetype = "Red"
    elsif winetype == "Rosé"
      winetype = "Rosé"
    elsif winetype == "Sparkling & Champagne"
      if wine_hash[:varietal] == "Port" or wine_hash[:varietal] == "Sherry" or wine_hash[:varietal] == "Madeira"
        winetype = "Sherry, Port, Madeira"
        varietal_from_hash = "Other: Sherry, Port, Madeira"
      elsif wine_hash[:varietal] == "Other Dessert"
        winetype = "Dessert"
        varietal_from_hash = "Other: Dessert"
      else
        winetype = "Sparkling and Champagne"
        varietal_from_hash = "Sparkling and Champagne"
      end
    end

    if varietal_from_hash == "Other Red Blends"
      varietal_from_hash = "Red Blends"
    elsif varietal_from_hash == "Other Red Wine"
      varietal_from_hash = "Red Blends"
    elsif varietal_from_hash == "Other White Blends"
      varietal_from_hash = "White Blends"
    elsif varietal_from_hash == "Other White Wine"
      varietal_from_hash = "White Blends"
    elsif varietal_from_hash == "Albarino"
      varietal_from_hash = "Albariño"
    end


    varietal = Varietal.find_or_create_by({
                                            name: varietal_from_hash, 
                                            wine_type: winetype
                                            })

    if wine_hash[:professional_reviews] == nil 
      prof_review = "N/A"
    else
      prof_review = wine_hash[:professional_reviews]
    end

    wine = Wine.create!({name: wine_hash[:name], 
                                      producer_id: producer.id,
                                      varietal_id: varietal.id,
                                      region_id: region.id,
                                      vintage: wine_hash[:vintage],
                                      price: wine_hash[:price],
                                      expert_rating: wine_hash[:expert_rating],
                                      description: wine_hash[:description],
                                      expert_review: prof_review,
                                      existing_avg_user_rating: wine_hash[:user_rating],
                                      existing_avg_user_rating_count: wine_hash[:user_rating_count],
                                      upc: wine_hash[:upc]
                                      })
    img = "https://" + wine_hash[:image_url]

    image = Image.create!({
                                        wine_id: wine.id,
                                        url: img
                                          })

  end
  

