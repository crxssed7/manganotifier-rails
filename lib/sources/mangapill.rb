# frozen_string_literal: true

module Sources
  class Mangapill < Base
    def image_headers
      {Referer: base_url}
    end

    private

    def base_url = "https://mangapill.com/manga/"

    def extract_image(document) = document.css("img")[0]["data-src"]

    def extract_name(document) = document.css("h1")[0].text

    def extract_last_chapter(document) = document.css("a.p-1")[0].text
  end
end
