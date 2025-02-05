require "rails_helper"

RSpec.describe "Movies API", type: :request do
    describe '#index' do
        it "can retrieve the top 20 rated movies", :vcr do

            get "/api/v1/movies"

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)
            
            expect(json[:data][0][:id]).to be_a(Integer)
            expect(json[:data][0][:type]).to eq("movie")
            expect(json[:data][0][:attributes]).to have_key(:title)
            expect(json[:data][0][:attributes]).to have_key(:vote_average)
            expect(json[:meta][:count]).to eq(20)
        end
    end
end