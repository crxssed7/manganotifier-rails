module MangasHelper
  # TODO: Figure out why we can't use url helpers in the lib/ folder
  def image_url_for(manga:)
    port = Rails.env.development? ? ":3000" : ""

    manga_image_path = Rails.application.routes.url_helpers.image_manga_path(manga)

    "#{PROTOCOL}://#{HOST}#{port}#{manga_image_path}"
  end
end
