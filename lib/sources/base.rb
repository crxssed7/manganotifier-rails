# frozen_string_literal: true
require "net/http"

module Sources
  class Base
    attr_reader :manga

    def initialize(manga:)
      @manga = manga
    end

    def crawl
      response = get_response
      if response.is_a? Net::HTTPSuccess
        document = parse_html(response.body)

        name = extract_name(document)
        image = extract_image(document)
        last_chapter = extract_last_chapter(document)

        manga.name = name
        manga.last_chapter = last_chapter
        manga.source = self.class.to_s.split("::").last
        manga.image = image
        manga.last_refreshed = Time.current

        return manga.save
      end
    end

    def refresh
      response = get_response
      if response.is_a? Net::HTTPSuccess
        document = parse_html(response.body)

        last_chapter = extract_last_chapter(document)
        original_last_chapter = manga.last_chapter

        manga.last_chapter = last_chapter
        manga.last_refreshed = Time.current
        manga.save

        return true if original_last_chapter != last_chapter
      end

      false
    end

    def image_headers = {}

    private

    def get_response
      uri = URI(item_url)
      Net::HTTP.get_response(uri)
    rescue URI::InvalidURIError
      # Just fake a bad request
      Net::HTTPUnknownResponse.new("", "", "")
    end

    def parse_html(html)
      Nokogiri::HTML.parse(html)
    end

    def item_url = "#{base_url}#{manga.external_id}"

    def base_url
      raise "Implement in subclass"
    end

    def extract_image(document)
      raise "Implement in subclass"
    end

    def extract_name(document)
      raise "Implement in subclass"
    end

    def extract_last_chapter(document)
      raise "Implement in subclass"
    end
  end
end
