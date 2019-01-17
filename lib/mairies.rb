# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

URL_PATH = 'http://annuaire-des-mairies.com/val-d-oise.html'

###############################################################################
# récupère l'email d'une mairie à partir de l'URL de cette dernière
# ###############################################################################
def get_townhall_email(partial_townhall_url)
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/" + partial_townhall_url))
  # selector = "//tbody/tr/td"
  email_townhalls = page.css('tbody tr:nth-child(4) td:nth-child(2)')
  #nettoyage de l'email
  email_townhall = email_townhalls[0]
   return email_townhall.text
end

###############################################################################
# retourne un tableau des liens relatifs des pages de toutes les communes du 95
###############################################################################
def get_townhall_list
  name_cities = []
  price_cryptos = []
  array_result = []
  links = []
  names_cities_page_links = []

  page = Nokogiri::HTML(open(URL_PATH))
  names_cities_page = page.css('a')
  links = names_cities_page.map { |link| link.attribute('href').to_s }.delete_if(&:empty?)
  # on enlève les 10 derniers liens qui ne sont pas ceux recherchés
  links = links[2..-10]
  # on enlève les 7 premiers liens qui ne sont pas ceux recherchés
  links = links[6..-1]
  # on enlève le . du début de l'url
  links.each do |city|
    names_cities_page_links << city[1..-1]
  end
  return names_cities_page_links
end

def perform
  get_townhall_list.each do |city_url|
    get_townhall_email(city_url)
  end
end

perform
