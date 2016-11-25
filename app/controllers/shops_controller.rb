require 'scraper'

class ShopsController < ApplicationController
  def index
    @total_scraped = Item.count
    @last_scraped = Item.last(100)
  end

  def scrape
    Scraper.new.scrape
  end
end
