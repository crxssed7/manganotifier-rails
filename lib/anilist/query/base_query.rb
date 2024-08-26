module Anilist
  module Query
    class BaseQuery
      def body
        {
          "query" => query,
          "variables" => variables.to_json
        }
      end

      private

      def query
        raise "Implement in subclass"
      end

      def variables
        raise "Implement in subclass"
      end
    end
  end
end
