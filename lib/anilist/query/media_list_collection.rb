module Anilist
  module Query
    class MediaListCollection
      def initialize(username, status)
        @username = username
        @status = status
      end

      def body
        {
          "query" => query,
          "variables" => variables.to_json
        }
      end

      private

      def query
        <<~QUERY
          query($userName: String, $status: MediaListStatus) {
            MediaListCollection(userName: $userName, type: MANGA, status: $status) {
              lists {
                name
                status
                entries {
                  id
                  progress
                  status
                  media {
                    id
                    title {
                      romaji
                      english
                      native
                    }
                    status
                    chapters
                    volumes
                  }
                }
              }
            }
          }
        QUERY
      end

      def variables
        {
          "userName" => @username,
          "status" => @status
        }
      end
    end
  end
end
