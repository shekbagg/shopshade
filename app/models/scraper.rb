require 'selenium-webdriver'
require 'phantomjs'
require 'watir'
require 'nokogiri'

SCRAPE_URL  = "https://incoming.shopify.com/"

class Scraper
  def scrape
    browser = Watir::Browser.new :phantomjs
    browser.window.maximize
    browser.goto SCRAPE_URL
    browser.wait_until { browser.element(id: 'products-title').visible? }
    while true do
      parser = Nokogiri::HTML(browser.html)
      shop_list = parser.css('div.map__sales-current-products').children
      shop_list.each do |child|
        update_or_create(child.attr('href'), child.css('div.map__product-details-url').text)
      end
      sleep 15
    end
    browser.close
  end

  def update_or_create(link, name)
    exist = Item.where(link:link, name:name).first
    if !exist
      store_url = link.match(/(.*)\/products/).captures.first
      Item.create(store:store_url, name: name, link: link)
      puts "Saved"
    end
  end
end
