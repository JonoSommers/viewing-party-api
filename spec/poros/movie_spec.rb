require 'rails_helper'

RSpec.describe Movie do
    it 'should create a Movie from JSON data' do
        sample_json = {
            title: 'testing movie',
            vote_average: 9.99
        }

        movie = Movie.new(sample_json)
        expect(movie).to be_an_instance_of (Movie)
        expect(movie.original_title).to eq ('testing movie')
        expect(movie.vote_average).to eq (9.99)
    end
end