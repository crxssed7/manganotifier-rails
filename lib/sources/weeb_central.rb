module Sources
  class WeebCentral < Base
    private

    def base_url = "https://weebcentral.com/series/"

    def extract_image(document) = document.css("img")[2]["src"]

    def extract_name(document) = document.css("h1.hidden")[0].text

    def extract_last_chapter(document) = document.css("span.grow > span")[0].text
  end
end
