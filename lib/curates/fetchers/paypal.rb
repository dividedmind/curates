require 'nokogiri'
require 'open-uri'

module Curates
  module Fetchers
    class Paypal
      BASE_URI = 'https://www.paypal.com/uk/cgi-bin/webscr?cmd=_manage-currency-conversion&amount_in=1&currency_in=%s&currency_out=%s&currency_conversion_type=%s'.freeze

      def current_rate src, dest, type = 'BalanceConversion'
        uri = BASE_URI % [src, dest, type]
        doc = Nokogiri::XML(open(uri))
        doc.xpath('//exchange_rate_formatted').first.content.to_f
      end
    end
  end
end
