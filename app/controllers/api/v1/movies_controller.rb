class Api::V1::MoviesController < ApplicationController
    def index
        top_rated = MovieGateway.top_rated_movies
        render json: MovieSerializer.format_movie(top_rated)
    end
end