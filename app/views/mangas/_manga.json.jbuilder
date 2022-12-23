json.extract! manga, :id, :name, :external_id, :last_chapter, :source, :image, :last_refreshed, :created_at, :updated_at
json.url manga_url(manga, format: :json)
