module Anilist
  class Request
    attr_reader :query

    def initialize(query)
      @query = query
    end

    def self.send(query)
      new(query).send
    end

    def send
      uri = URI("https://graphql.anilist.co")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new uri
      request.set_form_data(query.body)

      response = https.request(request)
      JSON.parse(response.body, symbolize_names: true) if response.is_a?(Net::HTTPOK)
    end
  end
end
