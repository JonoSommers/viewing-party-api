class Api::V1::MoviesController < ApplicationController
    def index
        if params[:title]
            movies = MovieGateway.movies_title_search(params[:title])
        else
            movies = MovieGateway.top_rated_movies
        end
    
        render json: MovieSerializer.format_movie(movies)
    end
    
end