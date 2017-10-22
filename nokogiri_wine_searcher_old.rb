require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open('https://www.wine-searcher.com/regions.lml'))
country_links = []

all_a_tags = page.css('html body div#container div#bodycontainer div div#colheader div#content-block div.colmaskresulttemp6.menuresulttemp6 div.colleftresulttemp6.align-l div.col2resulttemp6.noprint.align-l div#navigationpanel div#navigation ul.top-level li a')

all_a_tags.each do |country_link|
  country_links << country_link['href']
end

puts country_links




