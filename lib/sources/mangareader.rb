# frozen_string_literal: true

module Sources
  class Mangareader < Base
    private

    def base_url = "https://mangareader.to/"

    def extract_image(document) = document.css("img.manga-poster-img")[0]["src"]

    def name_selector = "h2.manga-name"

    def last_chapter_selector = "li.chapter-item span.name"
  end
end
