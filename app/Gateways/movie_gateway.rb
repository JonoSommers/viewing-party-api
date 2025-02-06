class MovieGateway
    def self.top_rated_movies
        response = conn.get("/3/movie/top_rated")
        json = JSON.parse(response.body, symbolize_names: true)
        movies = json[:results].map do |movie|
            Movie.new(movie)
        end
    end

    def self.movies_title_search(title)
        response = conn.get("/3/search/movie", { query: title })
        json = JSON.parse(response.body, symbolize_names: true)
        movies = json[:results].map do |movie|
            Movie.new(movie)
        end
        movies.sort_by!(&:vote_average)
        movies.reverse
    end

    private
    
    def self.conn
        Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers["Authorization"] = Rails.application.credentials.themoviedb[:key]
        end
    end
end