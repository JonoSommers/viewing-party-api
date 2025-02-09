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

    def self.compare_runtime_to_party_time(viewing_party)
        movie = MovieGateway.get_movie_data(viewing_party[:movie_id])
        party_duration = (viewing_party[:end_time].to_i - viewing_party[:start_time].to_i) / 60
        movie_length = movie[:runtime]
        if party_duration < movie_length
            raise StandardError, 'You cannot create a viewing party that will be shorter than the movie length'
        end
    end
end