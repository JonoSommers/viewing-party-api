class ViewingPartySerializer
    include JSONAPI::Serializer
    attributes :name, :start_time, :end_time, :movie_id, :movie_title

    attribute :invitees do |viewing_party|
        invitees = User.joins(:users_viewing_parties).where(users_viewing_parties: { host: false} )
        invitees.map do |user|
            {
                id: user.id,
                name: user.name,
                username: user.username
            }
        end
    end
end