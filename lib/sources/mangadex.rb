# frozen_string_literal: true

module Sources
  class Mangadex < Base
    private

    def parse_response(text)
      JSON.parse(text)
    end

    def refresh_url = "#{item_url}/feed?#{query_params_for_refresh}"

    def item_url = "#{base_url}manga/#{manga.external_id}"

    def base_url = "https://api.mangadex.org/"

    def extract_image(document)
      cover = document["data"]["relationships"].find { _1["type"] == "cover_art" }
      return "" unless cover.present?

      cover_id = cover["id"]

      uri = URI("#{base_url}cover/#{cover_id}")
      response = Net::HTTP.get_response(uri)
      return "" unless response.is_a? Net::HTTPSuccess

      cover_data = JSON.parse(response.body)
      filename = cover_data["data"]["attributes"]["fileName"]
      "https://uploads.mangadex.org/covers/#{manga.external_id}/#{filename}"
    end

    def extract_name(document)
      document["data"]["attributes"]["title"]["en"]
    end

    def extract_last_chapter(document)
      return manga.last_chapter unless document["data"].present? && document["data"].is_a?(Array)

      chapter = document["data"].first
      chapter_num = chapter["attributes"]["chapter"]
      chapter_title = chapter["attributes"]["title"]

      "Chapter #{[chapter_num, chapter_title].compact.join(": ")}"
    end

    def query_params_for_refresh
      qp = {
        "limit" => 1,
        "translatedLanguage[]" => "en",
        "order[volume]" => "desc",
        "order[chapter]" => "desc"
      }
      URI.encode_www_form(qp)
    end
  end
end
