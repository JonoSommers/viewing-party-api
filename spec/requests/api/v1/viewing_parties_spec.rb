require "rails_helper"

RSpec.describe "Viewing Parties API", type: :request do
    before(:each) do
        @user_1 = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "qwert12345")
        @invitee_1 = User.create!(name: "Arnold", username: "arnold_s", password: "password")
        @invitee_2 = User.create!(name: "Sylvester", username: "sly_stallone", password: "password")
    end
    describe '#create' do
        it "can create a viewing party", :vcr do
            body = {
                name: "Jono's Bday Movie Bash!",
                start_time: "2025-02-01 10:00:00",
                end_time: "2025-02-01 14:30:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption",
                invitees: [@invitee_1.id, @invitee_2.id]
            }

            post "/api/v1/users/#{@user_1.id}/viewing_parties", params: body, as: :json

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:data][:id]).to be_a (String)
            expect(json[:data][:type]).to eq ("viewing_party")
            expect(json[:data][:attributes]).to have_key (:name)
            expect(json[:data][:attributes]).to have_key (:start_time)
            expect(json[:data][:attributes]).to have_key (:end_time)
            expect(json[:data][:attributes]).to have_key (:movie_id)
            expect(json[:data][:attributes]).to have_key (:movie_title)
            expect(json[:data][:attributes]).to have_key (:invitees)
        end

        it 'should not create a viewing party with missing attributes', :vcr do
            body = {
                name: "Jono's Bday Movie Bash!",
                start_time: "2025-02-01 10:00:00",
                end_time: "2025-02-01 14:30:00",
                movie_title: "The Shawshank Redemption",
                invitees: [@invitee_1.id, @invitee_2.id]
            }

            post "/api/v1/users/#{@user_1.id}/viewing_parties", params: body, as: :json

            expect(response).not_to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(json[:message]).to eq("Validation failed: Movie can't be blank")
            expect(json[:status]).to eq(422)
        end

        it 'should not create a viewing party where the start time is after the end time', :vcr do
            body = {
                name: "Jono's Bday Movie Bash!",
                start_time: "2025-02-01 14:30:00",
                end_time: "2025-02-01 10:00:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption",
                invitees: [@invitee_1.id, @invitee_2.id]
            }

            post "/api/v1/users/#{@user_1.id}/viewing_parties", params: body, as: :json

            expect(response).not_to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:unprocessable_content)
            expect(json[:message]).to eq('Your start time cannot be after your end time')
        end

        it 'should create a viewing party even if the invitees array contains invalid user ids', :vcr do
            body = {
                name: "Jono's Bday Movie Bash!",
                start_time: "2025-02-01 10:00:00",
                end_time: "2025-02-01 14:30:00",
                movie_id: 278,
                movie_title: "The Shawshank Redemption",
                invitees: [@invitee_1.id, 999]
            }

            post "/api/v1/users/#{@user_1.id}/viewing_parties", params: body, as: :json

            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:data][:id]).to be_a (String)
            expect(json[:data][:type]).to eq ("viewing_party")
            expect(json[:data][:attributes]).to have_key (:name)
            expect(json[:data][:attributes]).to have_key (:start_time)
            expect(json[:data][:attributes]).to have_key (:end_time)
            expect(json[:data][:attributes]).to have_key (:movie_id)
            expect(json[:data][:attributes]).to have_key (:movie_title)
            expect(json[:data][:attributes]).to have_key (:invitees)
            expect(json[:data][:attributes][:invitees]).to eq ([{id: @invitee_1.id, name: @invitee_1.name, username: @invitee_1.username}])
        end
    end
end