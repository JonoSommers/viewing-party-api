class Movie
    attr_reader :id, :original_title, :vote_average
    
    def initialize(movie_data)
        @id = movie_data[:id]
        @original_title = movie_data[:title]
        @vote_average = movie_data[:vote_average]
    end
end