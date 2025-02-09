require "rails_helper"

RSpec.describe "Users viewing Party Model Methods", type: :request do
    describe '#host_not_set?' do
        it 'should return true if host is nil' do
            users_viewing_party = UsersViewingParty.new(host: nil)
            expect(users_viewing_party.host_not_set?).to be(true)
        end

        it 'should return false if host is not nil' do
            users_viewing_party = UsersViewingParty.new(host: true)
            expect(users_viewing_party.host_not_set?).to be(false)
        end
    end

    describe '#set_host_to_true' do
        it 'should update host to true if it is nil' do
            user = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "qwert12345")
            viewing_party = ViewingParty.create!(
            name: "Jono's Bday Movie Bash!", 
            start_time: "2025-02-01 14:30:00", 
            end_time: "2025-02-01 16:30:00", 
            movie_id: 278, 
            movie_title: "The Shawshank Redemption"
            )
            
            users_viewing_party = UsersViewingParty.new(user_id: user.id, viewing_party_id: viewing_party.id, host: nil)
            users_viewing_party.set_host_to_true

            expect(users_viewing_party.host).to be(true)
        end
    end
end