class Api::V1::MoviesController < ApplicationController
    def index
        movies = params[:title] ? MovieGateway.movies_title_search(params[:title]) : MovieGateway.top_rated_movies
        render json: MovieSerializer.format_movie(movies)
    end
end