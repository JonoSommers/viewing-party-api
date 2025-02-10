require "rails_helper"

RSpec.describe "Users viewing Party Requests", type: :request do
    describe '#Update' do
        it 'should add an invitee to an existing viewing party', :vcr do
            user = User.create(name: "Host User", username: "host_user", password: "password")
            invitee = User.create(name: "Invitee User", username: "invitee_user", password: "password")
            viewing_party = ViewingParty.create(name: "Movie Night", start_time: "2025-02-15 20:00:00", end_time: "2025-02-15 22:30:00", movie_id: 123, movie_title: "Inception")
            users_viewing_party = UsersViewingParty.create(user_id: user.id, viewing_party_id: viewing_party.id, host: true)

            patch "/api/v1/users/#{user.id}/viewing_parties/#{viewing_party.id}/users_viewing_parties/#{users_viewing_party.id}", params: { invitee_id: invitee.id }, as: :json 
            
            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)
            expect(response.status).to eq(200)
            expect(json[:data][:id]).to eq(viewing_party.id.to_s)
            expect(json[:data][:attributes][:invitees]).to include(a_hash_including(id: invitee.id, name: invitee.name))
        end
    end
end