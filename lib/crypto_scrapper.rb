require 'open-uri'
require 'nokogiri'

URL_PATH = 'https://coinmarketcap.com/all/views/all/'

def crypto_scrapper
  name_cryptos = []
  price_cryptos = []
  array_result = []

  page = Nokogiri::HTML(open(URL_PATH))
  # récup des noms
  names_cryptos_page = page.xpath('//td[@class="text-left col-symbol"]')
  names_cryptos_page.each do |name_crypto|
    name_cryptos << name_crypto.text
  end

  # récup des prix
  price_cryptos_page = page.xpath('//td/a[@class="price"]')
  price_cryptos_page.each do |price_crypto|
    # on enlève le $
    price_cryptos << price_crypto.text[1..-1]
  end

  # on crée un array de Hash
  name_cryptos.size.times do |i|
    array_result << [name_cryptos[i] => price_cryptos[i]]
  end
  return array_result
end

def perform
  crypto_scrapper
end

perform
