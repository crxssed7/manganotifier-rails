module Anilist
  module Query
    class User < BaseQuery
      def initialize(username)
        @username = username
      end

      private

      def query
        <<~QUERY
          query($name: String) {
            User(name: $name) {
              avatar {
                medium
              }
              name
              siteUrl
            }
          }
        QUERY
      end

      def variables
        {
          "name" => @username
        }
      end
    end
  end
end
