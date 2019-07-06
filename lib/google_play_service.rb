require 'httpclient'
require 'nokogiri'
require 'uri'

module GooglePlayService
  class ParsePageApp
    attr_reader :doc
    attr_accessor :name, :ref_icon, :category, :rating, :dowloads, :author, :author_email 

    def initialize(url)
      @doc = parse_page_html(url)
      create_info_app
      puts "information received by the application"
    end

    def create_info_app
      self.name = app_name
      self.ref_icon = app_ref_icon
      self.category = app_category
      self.rating = app_rating
      self.dowloads = app_total_dowloads
      self.author = app_website_developer
      self.author_email = app_email_developer
    end

    private

    def parse_page_html(url)
      url_parse = URI.parse(url)
      client = HTTPClient.new
      html = client.get(url_parse).body
      Nokogiri::HTML(html)
    end

    def app_name
      name = @doc.at("[itemprop='name']")
      name.content.strip if name
    end

    def app_ref_icon
      # @doc.css("div.xSyT2c")[0].children[0].values.first
      ref = @doc.at("[itemprop='image']").values.first
      ref.strip if ref
    end

    def app_category
      category = @doc.at("span a[itemprop='genre']")
      category.content.strip if category
    end

    def app_rating
      rating = @doc.css('div.BHMmbe')[0]
      rating.content.strip if rating
    end

    def app_total_dowloads
      dowloads = @doc.css('span.EymY4b')[0].children[1]
      dowloads.content.strip.delete(',') if dowloads
    end

    def app_website_developer
      # @doc.search("span.htlgb a.hrTbp")[1]['href']
      website = @doc.css('a.hrTbp')[3]['href']
      website.strip if website
    end

    def app_email_developer
      # @doc.doc.search("a.hrTbp")[4].content
      email = @doc.css('a.hrTbp')[4]
      email.content.strip if email
    end
  end
end
