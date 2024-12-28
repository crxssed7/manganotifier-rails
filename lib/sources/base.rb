# frozen_string_literal: true
require "net/http"

module Sources
  class Base
    attr_reader :manga

    def initialize(manga:)
      @manga = manga
    end

    def crawl
      response = get_response(item_url)
      if response.is_a? Net::HTTPSuccess
        document = parse_response(response.body)

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
      response = get_response(refresh_url)
      if response.is_a? Net::HTTPSuccess
        document = parse_response(response.body)

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

    def use_proxy? = false

    def get_response(url)
      uri = URI(url)
      use_proxy? ? proxy_response(url) : response(uri)
    rescue URI::InvalidURIError
      # Just fake a bad request
      Net::HTTPUnknownResponse.new("", "", "")
    end

    def response(uri)
      Net::HTTP.get_response(uri)
    end

    def proxy_response(url)
      uri = URI("https://us9.proxysite.com/includes/process.php?action=update")
      fetch_with_redirect(uri, {d: url}, {Referer: "https://www.proxysite.com/"})
    end

    def fetch_with_redirect(uri, form_data = {}, headers = {}, limit = 10)
      return Net::HTTPUnknownResponse.new("", "", "") if limit == 0

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(form_data)

      # Set headers
      headers.each { |key, value| request[key] = value }

      response = https.request(request)

      if response.is_a?(Net::HTTPFound)
        location = response['location']
        puts "Redirected to #{location}"
        fetch_with_redirect(URI(location), form_data, headers, limit - 1)
      else
        response
      end
    end

    def parse_response(text)
      Nokogiri::HTML.parse(text)
    end

    def refresh_url = item_url

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
