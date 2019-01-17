require 'open-uri'
require 'nokogiri'

URL_PATH = 'http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'

def deputies

  name_deputies = []
puts "start"
  page = Nokogiri::HTML(open(URL_PATH))
  # récup des noms
  # names_pages = page.xpath("//div[@id='deputes-list']")
  names_pages = page.css("div[id='deputes-list'] div ul li a")
  names_pages.each do |name_deputy|
    name_deputies << name_deputy.text 
  end
  puts name_deputies
end

def perform
  deputies
end

perform
