class ViewingParty < ApplicationRecord
    has_many :users_viewing_parties
    has_many :users, through: :users_viewing_parties

    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    validates :movie_title, presence: true

    def self.add_invitees_to_joins_table(invitees_param, party)
        invitees_param.each do |invitee_id|
            UsersViewingParty.create(user_id: invitee_id, viewing_party_id: party.id, host: false)
        end
    end

    def check_if_party_ends_before_starting(starting_time, ending_time)
        if starting_time > ending_time
            raise StandardError, 'Your start time cannot be after your end time'
        end
    end
end