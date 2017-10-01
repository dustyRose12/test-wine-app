# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Country.create!([
                          {name: "Germany"},
                          {name: "France"},
                          {name: "US"}
                          ])

Region.create([
                      {name: "Mosel", country_id: 1},
                      {name: "Alsace", country_id: 2},
                      {name: "Sonoma", country_id: 3}
                      ])

Producer.create!([
                            {name: "Fritz Haag"},
                            {name: "Jean-Baptiste Adam"},
                            {name: "Failla"}
                            ])

Varietal.create!([
                        {name: "Riesling", wine_type: "white"}
                        {name: "Chardonnay", wine_type: "white"}
                        ])

# Category.create!([
#                           {name: "bla bla"}
#                           ])

Wine.create!([
                      {producer_id: 1, name: "Brauneberger Kabinett", varietal_id: 1, vintage: 2014, region_id: 1, price: 32, expert_rating: 93, alcohol: "8%", ml: 750, description: "Irresistably juicy and fruity, yet so delicately nuanced by spice, earth and mineral, this light-footed kabinett encapsulates much of what's so special about Mosel Riesling. The palate bursts with rich yellow peach and mango, but nervous lemon-lime acidity lends an electric vibe. It's delicious now but should improve through 2021."},
                       {producer_id: 2, name: "Letzenberg", varietal_id: 1, vintage: 2015, region_id: 2, price: 36, expert_rating: 94, alcohol: "13%", ml: 750, description: "Intense lemon and tangerine notes create a most inviting nose. The palate continues in full tangy mode: the aromatic zest of tangerine and ripe Amalfi lemon create a concentrated, uplifting and even cooling freshness. The body is slender but totally concentrated with a dynamic linear structure. Over time, riper notes of honeyed stone fruit appear despite the very dry style, but the chief charms are a marvel of citrus diversity. Drink now through 2035."},
                         {producer_id: 3, name: "Estate Vineyard", varietal_id: 2, vintage: 2010, region_id: 3, price: 44, expert_rating: 99, alcohol: "14.2%", ml: 750, description: "Shows classic, full-throttle notes of tropical and citrus fruits, pears and sweet green apples, combined with strong minerality and complex layers of buttered toast, honey and creamy lees. The description alone hardly does justice to the wine's beauty. The acidity is perfect, the oak deftly applied, the finish long and completely satisfying."}
                      ])

# CategoryWine.create!([
#                                   {wine_id: 10, category_id:10}
#                                   ])

Image.create!([
                        {wine_id: 1, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/234352_117be_jun16_3660.jpg"},
                        {wine_id: 2, url: "http://www.thesortingtable.com/wp-content/uploads/2015/07/Jean-Baptiste_Riesling-Letzenberg-300-dpi-700x1024.jpg"},
                        {wine_id: 3, url: "http://www.winemag.com/wp-content/assets/reviews/label-images/wine/wine/152203_WEB1_JULY12_3017.jpg"}
                        ])

User.create!([
                    {name: "Rocio Cifrian", email: "rocio87@gmail.com", password_digest: "password", username: "rocio87", profile_pic: "http://www.theworldwidewine.com/Wine_reviews/Weekly_cheap_wine_reviews/Section2/mosel_castle_in_tasting_cheap_wine.jpg"}
                    ])

# Review.create!([
#                       {user_id: 1, wine_id: 1, rating: 4.5, description: "Amazing!"}
#                       ])

# Pin.create!([
#                     {user_id: 10, wine_id: 10}
#                     ])