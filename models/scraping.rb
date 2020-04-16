# frozen_string_literal: true

class Scraping < Kimurai::Base
  @name = 'scraping'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//article[@class='productCard.grid-cell']").each do |rod|
      item = {}

      item[:title] = rod.css('h6.productCard-heading')&.text&.squish
      # item[:price] = rod.css('span.price-primary')&.text&.squish&.delete('^0-9').to_i
      # item[:stock_type] = vehicle.css('div.listing-row__stocktype')&.text&.squish
      # item[:miles]      = vehicle.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
      # item[:exterior_color] = vehicle.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
      # item[:interior_color] = vehicle.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
      # item[:transmission] = vehicle.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
      # item[:drivetrain]   = vehicle.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')

      Rod.where(item).first_or_create
    end
  end
end
