require 'httpclient'
require 'nokogiri'
require 'uri'
require_relative './helper'

module GooglePlayService
  class ParsePageApp
    attr_reader :doc
    attr_accessor :name, :ref_icon, :category, :rating, :dowload_count, :author, :author_email

    def initialize(url)
      @doc = parse_page_html(url)
      create_info_app
      puts 'information received by the application'
    end

    def create_info_app
      self.name = app_name
      self.ref_icon = app_ref_icon
      self.category = app_category
      self.rating = app_rating
      self.dowload_count = app_total_dowloads
      self.author = app_website_developer
      self.author_email = app_email_developer
    end

    private

    def parse_page_html(url)
      Nokogiri::HTML(check_url(url))
    end

    def app_name
      name = @doc.at("[itemprop='name']")
      name.content.strip if name
    rescue NoMethodError
      display_error('name')
    end

    def app_ref_icon
      # @doc.css("div.xSyT2c")[0].children[0].values.first
      ref = @doc.at("[itemprop='image']").values.first
      ref.strip if ref
    rescue NoMethodError
      display_error('ref_icon')
    end

    def app_category
      category = @doc.at("span a[itemprop='genre']")
      category.content.strip if category
    rescue NoMethodError
      display_error('category')
    end

    def app_rating
      rating = @doc.css('div.BHMmbe')[0]
      rating.content.strip if rating
    rescue NoMethodError
      display_error('rating')
    end

    def app_total_dowloads
      dowloads = @doc.css('span.EymY4b')[0].children[1]
      dowloads.content.strip.delete(',') if dowloads
    rescue NoMethodError
      display_error('dowload_count')
    end

    def app_website_developer
      # @doc.search("span.htlgb a.hrTbp")[1]['href']
      website = @doc.css('a.hrTbp')[3]['href']
      website.strip if website
    rescue NoMethodError
      display_error('author')
    end

    def app_email_developer
      # @doc.doc.search("a.hrTbp")[4].content
      email = @doc.css('a.hrTbp')[4]
      email.content.strip if email
    rescue NoMethodError
      display_error('author_email')
    end

    def check_url(url)
      url_parse = URI.parse(url)
      client = HTTPClient.new
      response = client.get(url_parse)
      case response.code
      when 401
        puts 'Received http error 401'
      when 403
        puts 'Received http error 403'
      when 404
        puts 'Received http error 404'
      when 500
        puts 'Received http error 500'
      when 503
        puts 'Received http error 503'    
      else
        response.body
      end
    end
  end
end
