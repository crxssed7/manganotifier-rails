# frozen_string_literal: true

module Sources
  class Mangareader < Base
    private

    def base_url = "https://mangareader.to/"

    def extract_image(document) = document.css("img.manga-poster-img")[0]["src"]

    def extract_name(document) = document.css("h2.manga-name")[0].text

    def extract_last_chapter(document) = document.css("ul#en-chapters li.chapter-item span.name")[0].text
  end
end
