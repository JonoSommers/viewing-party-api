require "rails_helper"

RSpec.describe MovieGateway do
    it 'should make a call to TMDB to retreive the top 20 rated movies', :vcr do
        json_response = MovieGateway.top_rated_movies
        expect(json_response.first).to respond_to (:original_title)
        expect(json_response.first).to respond_to (:vote_average)
        expect(json_response.first.original_title).to be_a (String)
        expect(json_response.first.vote_average).to be_a (Float)
    end

    it 'should make a call to TMDB to retreive the top 20 rated movies based on the query', :vcr do
        json_response = MovieGateway.movies_title_search('Lor')
        expect(json_response.first).to respond_to (:original_title)
        expect(json_response.first).to respond_to (:vote_average)
        expect(json_response.first.original_title).to be_a (String)
        expect(json_response.first.original_title).to eq ("The Lord of the Rings: The Return of the King")
        expect(json_response.first.vote_average).to be_a (Float)
        expect(json_response.first.vote_average). to be > (json_response.second.vote_average)
    end
end