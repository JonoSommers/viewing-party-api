class MovieSerializer
    include JSONAPI::Serializer
    attributes :title, :vote_average

    def self.format_movie(movies)
        { data:
            movies[:results].map do |movie|
                {
                    id: movie[:id].to_s,
                    type: "movie",
                    attributes: {
                        title: movie[:original_title],
                        vote_average: movie[:vote_average]
                    }
                }
            end,
            meta: {
                count: movies[:results].count
            }
        }
    end
end