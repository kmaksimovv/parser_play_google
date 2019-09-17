require 'spec_helper'

describe 'GooglePlayService::ParsePageApp' do
  describe '#new' do
    let(:url) { 'https://play.google.com/store/apps/details?id=com.idamob.tinkoff.android' }

    before do
      stub_request(:any, 'https://play.google.com/store/apps/details?id=com.idamob.tinkoff.android')
        .to_return(body: File.new('spec/fixtures/files/index.html'), status: 200)
      @gps = GooglePlayService::ParsePageApp.new(url)
      @doc = Nokogiri::HTML(File.read('spec/fixtures/files/index.html'))
    end

    it 'testing get name app`s' do
      expect(@gps.name).to eq @doc.at("[itemprop='name']").content.strip
    end

    it 'testing get path to image app`s' do
      expect(@gps.ref_icon).to eq @doc.at("[itemprop='image']").values.first.strip
    end

    it 'testing get сategory app`s' do
      expect(@gps.category).to eq @doc.at("span a[itemprop='genre']").content.strip
    end

    it 'testing get rating app`s' do
      expect(@gps.rating).to eq @doc.css('div.BHMmbe')[0].content.strip
    end

    it 'testing get dowloads app`s' do
      expect(@gps.dowload_count).to eq @doc.css('span.EymY4b')[0].children[1].content.strip.delete(',')
    end

    it 'testing get author app`s' do
      expect(@gps.author).to eq @doc.css('a.hrTbp')[3]['href'].strip
    end

    it 'testing get author  email app`s' do
      expect(@gps.author_email).to eq @doc.css('a.hrTbp')[4].content.strip
    end
  end
end
