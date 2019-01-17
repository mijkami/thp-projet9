require 'open-uri'
require 'nokogiri'
require 'pry'

URL_PATH = 'http://annuaire-des-mairies.com/val-d-oise.html'

###############################################################################
# récupère l'email d'une mairie à partir de l'URL partielle de cette dernière
# ###############################################################################
def get_townhall_email(partial_townhall_url)
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/' + partial_townhall_url))
  # selector = "//tbody/tr/td"
  email_townhalls = page.css('tbody tr:nth-child(4) td:nth-child(2)')
  # nettoyage de l'email
  email_townhall = email_townhalls[0]
  email_townhall.text
end

###############################################################################
# retourne un tableau des liens relatifs des pages de toutes les communes du 95
# et un tableau du nom des villes
###############################################################################
def get_townhall_list
  name_cities = []
  price_cryptos = []
  array_result = []
  links = []
  names_cities_page_links = []

  page = Nokogiri::HTML(open(URL_PATH))
  # recupération des liens et création du tableau du nom des villes
  names_cities_page = page.css('a').each { |node| name_cities << node.text }
  # on enlève les premiers noms qui ne sont pas ceux recherchés
  name_cities = name_cities[8..-2]

  # links = names_cities_page.map { |link| link.attribute('href').to_s }.delete_if(&:empty?)
  links = names_cities_page.map { |link| link.attribute('href').to_s }.delete_if(&:empty?)
  # on enlève les 10 derniers liens qui ne sont pas ceux recherchés
  links = links[2..-2]
  # on enlève les premiers liens qui ne sont pas ceux recherchés
  links = links[6..-1]

  links.each do |city|
    names_cities_page_links << city[1..-1]
  end
  [name_cities, names_cities_page_links]
end

def perform
  result_array = []
  print 'Construction du tableau '
  partial_urls = get_townhall_list[1]
  townhall_names = get_townhall_list[0]
  # construction du tableau
  partial_urls.size.times do |index_townhall|
    name_townhall_city = townhall_names[index_townhall]
    email_townhall_city = get_townhall_email(partial_urls[index_townhall])
    result_array << [name_townhall_city => email_townhall_city]
    print '.'
  end
  puts result_array
end

perform
