old_seeds.rb

Country.create!([
                          {name: "Germany"},
                          {name: "France"},
                          {name: "US"},
                          {name: "Italy"},
                          {name: "Spain"},
                          {name: "Chile"}
                          ])

Region.create!([
                      {name: "Mosel", country_id: 1},
                      {name: "Alsace", country_id: 2},
                      {name: "Sonoma", country_id: 3},
                      {name: "Napa", country_id: 3},
                      {name: "Tuscany", country_id: 4},
                      {name: "Rioja", country_id: 5},
                      {name: "Colchagua Valley", country_id: 6},
                      {name: "Champagne", country_id: 2},
                      {name: "Priorat", country_id: 5}
                      ])

Producer.create!([
                            {name: "Fritz Haag"},
                            {name: "Jean-Baptiste Adam"},
                            {name: "Failla"},
                            {name: "Alpha Omega"},
                            {name: "Williams Selyem"},
                            {name: "Baricci"},
                            {name: "Bodegas Roda"},
                            {name: "Lapostolle"},
                            {name: "Louis Roederer"},
                            {name: "Terroir Al Límit"}
                            ])

Varietal.create!([
                        {name: "Riesling", wine_type: "White"},
                        {name: "Chardonnay", wine_type: "White"},
                        {name: "Cabernet Sauvignon", wine_type: "Red"},
                        {name: "Pinot Noir", wine_type: "Red"},
                        {name: "Sangiovese", wine_type: "Red"},
                        {name: "Tempranillo", wine_type: "Red"},
                        {name: "Red Blend", wine_type: "Red"},
                        {name: "Champagne", wine_type: "Sparkling"},
                        {name: "Rosé", wine_type: "Rosé"}
                        ])

# Category.create!([
#                           {name: "bla bla"}
#                           ])

Wine.create!([
                      {producer_id: 1, name: "Brauneberger Kabinett", varietal_id: 1, vintage: 2014, region_id: 1, price: 32, expert_rating: 93, alcohol: "8%", ml: 750, description: "Irresistably juicy and fruity, yet so delicately nuanced by spice, earth and mineral, this light-footed kabinett encapsulates much of what's so special about Mosel Riesling. The palate bursts with rich yellow peach and mango, but nervous lemon-lime acidity lends an electric vibe. It's delicious now but should improve through 2021."},

                       {producer_id: 2, name: "Letzenberg", varietal_id: 1, vintage: 2015, region_id: 2, price: 36, expert_rating: 94, alcohol: "13%", ml: 750, description: "Intense lemon and tangerine notes create a most inviting nose. The palate continues in full tangy mode: the aromatic zest of tangerine and ripe Amalfi lemon create a concentrated, uplifting and even cooling freshness. The body is slender but totally concentrated with a dynamic linear structure. Over time, riper notes of honeyed stone fruit appear despite the very dry style, but the chief charms are a marvel of citrus diversity. Drink now through 2035."},

                         {producer_id: 3, name: "Estate Vineyard", varietal_id: 2, vintage: 2010, region_id: 3, price: 44, expert_rating: 99, alcohol: "14.2%", ml: 750, description: "Shows classic, full-throttle notes of tropical and citrus fruits, pears and sweet green apples, combined with strong minerality and complex layers of buttered toast, honey and creamy lees. The description alone hardly does justice to the wine's beauty. The acidity is perfect, the oak deftly applied, the finish long and completely satisfying."},

                         {producer_id: 4, name: "Beckstoffer Georges III", varietal_id: 3, vintage: 2009, region_id: 4, price: 250, expert_rating: 97, alcohol: "14.9%", ml: 750, description: "This 100% varietal and barrel-fermented wine is a remarkable study in power and grace. Black cherry, cigar box and cedar bark flavors and an invitingly sweet sensation of tannin are supported by bright, lingering acidity and supple complexity."},

                          {producer_id: 5, name: "Coastlands Vineyard", varietal_id: 4, vintage: 2014, region_id: 3, price: 75, expert_rating: 98, alcohol: "13.3%", ml: 750, description: "Pretty as all get-out, this wine is a floral masterpiece—a study in coastal rose and forest scents with a counterpunch of white pepper that leaves one wanting more. Juicy raspberry, strawberry and tangerine flavors are seasoned in allspice and tobacco, the palate so beautifully delicate yet fully realized in savory complexity and length."},

                          {producer_id: 6, name: "Nello Riserva", varietal_id: 5, vintage: 2010, region_id: 5, price: 120, expert_rating: 98, alcohol: "14.5%", ml: 750, description: "New leather, mature black-skinned fruit, tilled soil and a touch of dark spice are some of the aromas you'll find on this fantastic, full-bodied red. The big, velvety palate shows power and finesse, offering mouthfuls of juicy wild cherry, black raspberry, licorice, Mediterranean herb and a note of exotic spice framed in firm, ripe tannins. It's already balanced and delicious, but hold for more complexity. Drink 2020–2035."},

                           {producer_id: 7, name: "Cirsion", varietal_id: 6, vintage: 2009, region_id: 6, price: 250, expert_rating: 97, alcohol: "14.5%", ml: 750, description: "Solid as a battleship, with lemony oak, marzipan and layer upon layer of black fruit aromas. Almost syrupy in its richness but not fully; it's chewy and creamy, with vital acids. The flavors are mega ripe and rich, emphasizing blackberry, black cherry preserves, fudge and fig paste. Yet at the same time it's an ethereal wine; the epitome of modern Rioja."},

                            {producer_id: 8, name: "Clos Apalta", varietal_id: 7, vintage: 2011, region_id: 7, price: 110, expert_rating: 95, alcohol: "14.2%", ml: 750, description: "Cool aromas of cola, coffee, blackberry, stewed plum, herbs and minerals make for a highly attractive and complex bouquet. In the mouth, wall-to-wall power and tannins suggest that this needs a few more years to mellow out. Flavors of stewed plum, blackberry, Carolina barbecue sauce and a hint of citrus peel are complex and set up a deep finish with dark flavors and intensity to spare. Drink from 2016 through 2025. The blend is 57% Carmenère, 34% Cabernet Sauvignon and 9% Merlot."},

                              {producer_id: 9, name: "Cristal Brut", varietal_id: 8, vintage: 2009, region_id: 8, price: 249, expert_rating: 97, alcohol: "12%", ml: 750, description: "The latest incarnation of this famous Champagne now comes from Roderer's own vineyards, a good portion of which are run on biodynamic lines. This still-young wine has great depth and richness, a beautiful balance between ripe fruit and crisp texture that make it alive, crisp and bright. As it matures, it will deepen and become even more intense. Drink now if you must, but preferably wait until 2019."},
                              
                              {producer_id: 10, name: "Roc d'Aubaga", varietal_id: 9, vintage: 2016, region_id: 9, price: 50, expert_rating: 92, alcohol: "13.5%", ml: 750, description: "Like an ugly duckling that's a beautiful swan in waiting, this unique rosé, if you can call it that given its rusty, almost brown color, is something only Terroir Al Limít would bottle. Earthy in aromas, this mix of several Grenache strains tastes of apricot and dried red fruits. It's mildly spicy throughout, with actual tannins from skin contact. Drink this quasi rosé as you would a serious white or red, meaning with good food like a Catalan-style rice dish. And drink now."}                 
                      ])

# Create Categories later
# CategoryWine.create!([
#                                   {wine_id: 10, category_id:10}
#                                   ])

Image.create!([
                        {wine_id: 1, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/234352_117be_jun16_3660.jpg"},
                        {wine_id: 2, url: "http://www.thesortingtable.com/wp-content/uploads/2015/07/Jean-Baptiste_Riesling-Letzenberg-300-dpi-700x1024.jpg"},
                        {wine_id: 3, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/152203_WEB1_JULY12_3017.jpg"},
                        {wine_id: 4, url: "https://wine-searcher1.freetls.fastly.net/images/labels/28/78/alpha-omega-beckstoffer-georges-iii-cabernet-sauvignon-rutherford-usa-10402878.jpg"},
                        {wine_id: 5, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/255737_94be_apr17_3760.jpg"},
                        {wine_id: 6, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/233171_36be_dectopcs16_3720.jpg"},
                        {wine_id: 7, url: "http://roda.es/typo3temp/pics/7a8bd2dbb5.jpg"},
                        {wine_id: 8, url: "https://wine-searcher1.freetls.fastly.net/images/labels/94/96/casa-lapostolle-clos-apalta-colchagua-valley-chile-10209496.jpg"},
                        {wine_id: 9, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/249693_38be_dec16_3720.jpg"},
                        {wine_id: 10, url: "https://www.mwcwine.com/images/sites/mwcwine/labels/w2314902of_1.jpg"}
                        ])

# Deleted this, did it through the signup page instead
# User.create!([
#                     {name: "Rocio Cifrian", email: "rocio87@gmail.com", password_digest: "password", username: "rocio87", profile_pic: "http://www.theworldwidewine.com/Wine_reviews/Weekly_cheap_wine_reviews/Section2/mosel_castle_in_tasting_cheap_wine.jpg"}
#                     ])

Review.create!([
                      {user_id: 1, wine_id: 1, rating: 5.0, description: "Amazing!"}
                      ])

#Manually deleted this so I can re-do via the Pin view
# Pin.create!([
#                     {user_id: 1, wine_id: 1}
#                     ])