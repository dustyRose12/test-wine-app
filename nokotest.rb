require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
# doc = Nokogiri::HTML(open('http://www.nokogiri.org/tutorials/installing_nokogiri.html'))

# puts "### Search for nodes by css"
# doc.css('nav ul.menu li a', 'article h2').each do |link|
#   puts link.content
# end

page = Nokogiri::HTML(open('http://www.snooth.com/wines/'))
first_page_wines = []
first_page_names = []
first_page_descriptions = []
first_page_wine_links = []

#grabs the name
puts "### Search for nodes by css"
page.css('html body#bd div#main div.wrap div#main-col div.inner-wrap div.left-col div#wine-search div.results-container div.search-results div.result-items div.center div.wine-name').each do |wine_name|
  first_page_names << wine_name.text
end
puts first_page_names.length
#what type of data is it? weird n characters if you do:
# p first_page_names

#grabs the description
puts "### Search for nodes by css"
page.css('html body#bd div#main div.wrap div#main-col div.inner-wrap div.left-col div#wine-search div.results-container div.search-results div.result-items div.center div.snippet').each do |wine_snippet|
  first_page_descriptions << wine_snippet.text
end
puts first_page_descriptions.length

# -----------------
puts "### Search for nodes by css"
all_a_tags = page.css('html body#bd div#main div.wrap div#main-col div.inner-wrap div.left-col div#wine-search div.results-container div.search-results div.result-items div.item div.center div.wine-name a')


all_a_tags.each do |wine_link|
  first_page_wine_links << wine_link['href']
end

puts first_page_wine_links