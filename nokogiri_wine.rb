require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open('https://www.wine.com/list/wine/7155?sortBy=topRated'))
first_100_links = []


# search for first 100 wine links:
# puts "First 100 wine links:"

# how do i stop it at 100 so it doesn't infinitely scroll??
# all_a_tags = page.css('html body div.mobilePage div.scrollableContent main div.listPage_mainContent section.products ul.prodList li.prodItem div.prodItem_wrap div.prodItemThumb a.prodItemThumb_link')

# all_a_tags.each do |wine_link|
#   first_100_links << wine_link['href']
# end

# puts first_100_links

#search for specific wine info on each wine's page:
sample_wine_page = Nokogiri::HTML(open('https://www.wine.com/product/peter-michael-point-rouge-chardonnay-2014/166067'))

# producer name & wine name is smashed together into 1 (the year/vintage also, but we can back that out of the string by taking out the last 5 characters)
wine_page_info =  {name: "", varietal: "", vintage: "", region: "", country: "", price: "", description: "", expert_ratings: [], image_url: ""}

wine_page_info[:name] = sample_wine_page.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo h1.pipName').text

wine_page_info[:varietal] = sample_wine_page.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.pipOrigin span.prodItemInfo_varietal').text

wine_page_info[:vintage] = sample_wine_page.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo h1.pipName').text.split(//).last(4).join

wine_page_info[:region] = sample_wine_page.css('html body div.mobilePage div.scrollableContent main section.pipMainContent div.pipInfo div.pipProdInfo div.pipOrigin span.prodItemInfo_originText').text

#need to figure out how to back out the country from the region. international wines have the region+country line all together. US wines have no country listed, just the region + state.
