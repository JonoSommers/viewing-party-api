class Api::V1::MoviesController < ApplicationController
    def index
        params[:title] ? movies = MovieGateway.movies_title_search(params[:title]) : movies = MovieGateway.top_rated_movies
        render json: MovieSerializer.format_movie(movies)
    end
end