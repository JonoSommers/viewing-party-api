require "rails_helper"

RSpec.describe "Viewing Parties Model Methods", type: :request do
    before(:each) do
        @user_1 = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "qwert12345")
        @invitee_1 = User.create!(name: "Arnold", username: "arnold_s", password: "password")
        @invitee_2 = User.create!(name: "Sylvester", username: "sly_stallone", password: "password")
        @viewing_party1 = ViewingParty.create(name: "Jono's Bday Movie Bash!", 
            start_time: "2025-02-01 14:30:00", 
            end_time: "2025-02-01 10:00:00", 
            movie_id: 278, 
            movie_title: "The Shawshank Redemption"
        )
        @invitees_param = [@invitee_1.id, @invitee_2.id]
    end
    describe 'self.add_invitees_to_joins_table' do
        it 'should create invitee records on the joins table', :vcr do
            ViewingParty.add_invitees_to_joins_table(@invitees_param, @viewing_party1)

            expect(@viewing_party1.users_viewing_parties[0].user_id).to eq (@invitee_1.id)
            expect(@viewing_party1.users_viewing_parties[1].user_id).to eq (@invitee_2.id)
            expect(@viewing_party1.users_viewing_parties[0].viewing_party_id).to eq (@viewing_party1.id)
            expect(@viewing_party1.users_viewing_parties[1].viewing_party_id).to eq (@viewing_party1.id)
            expect(@viewing_party1.users_viewing_parties[0].host).to be (false)
            expect(@viewing_party1.users_viewing_parties[1].host).to be (false)
        end
    end

    describe 'check_if_party_ends_before_starting' do
        it 'should throw an error if the start time is after the end time', :vcr do
            expect{@viewing_party1.check_if_party_ends_before_starting(@viewing_party1.start_time, @viewing_party1.end_time)}.to raise_error(StandardError, 'Your start time cannot be after your end time')
        end
    end
end