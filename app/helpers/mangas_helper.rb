module MangasHelper
  # TODO: Figure out why we can't use url helpers in the lib/ folder
  def image_url_for(manga:)
    protocol = Rails.application.routes.default_url_options[:protocol]
    host = Rails.application.routes.default_url_options[:host]
    port = Rails.env.development? ? ":3000" : ""

    manga_image_path = Rails.application.routes.url_helpers.image_manga_path(manga)

    "#{protocol}://#{host}#{port}#{manga_image_path}"
  end
end
