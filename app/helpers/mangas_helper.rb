module MangasHelper
  # TODO: Figure out why we can't use url helpers in the lib/ folder
  def image_url_for(manga:)
    protocol = ENV["MANGA_NOTIFIER_PROTOCOL"] || "http"
    host = ENV["MANGA_NOTIFIER_HOST"] || "localhost"
    port = Rails.env.development? ? ":3000" : ""

    manga_image_path = Rails.application.routes.url_helpers.image_manga_path(manga)

    "#{protocol}://#{host}#{port}#{manga_image_path}"
  end
end
