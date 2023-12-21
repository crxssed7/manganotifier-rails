# frozen_string_literal: true

module Sources
  class Mangapill < Base
    private

    def base_url = "https://mangapill.com/manga/"

    def extract_image(document) = document.css("img")[0]["data-src"]

    def name_selector = "h1"

    def last_chapter_selector = "a.p-1"
  end
end
