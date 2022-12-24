# frozen_string_literal: true
require "net/http"
require "uri"

module Sources
  class Mangapill
    attr_accessor :manga

    def initialize(manga:)
      @manga = manga
    end

    def crawl
      uri = URI("https://mangapill.com/manga/#{manga.external_id}")
      res = Net::HTTP.get_response(uri)
      if res.is_a? Net::HTTPSuccess
        html = res.body
        document = Nokogiri::HTML.parse(html)
        name = document.css("h1")[0].text
        image = document.css("img")[0]["data-src"]
        last_chapter = document.css("a.p-1")[0].text
  
        manga.name = name
        manga.last_chapter = last_chapter
        manga.source = "mangapill"
        manga.image = image
        manga.last_refreshed = Time.current
        return manga.save
      end
    end

    def refresh
      # Get the last chapter of the manga
      uri = URI("https://mangapill.com/manga/#{manga.external_id}")
      res = Net::HTTP.get_response(uri)
      if res.is_a? Net::HTTPSuccess
        html = res.body
        document = Nokogiri::HTML.parse(html)
        last_chapter = document.css("a.p-1")[0].text

        if last_chapter != manga.last_chapter
          # Trigger the notifier.
        end

        manga.last_chapter = last_chapter
        manga.last_refreshed = Time.current
      end
    end
  end
end