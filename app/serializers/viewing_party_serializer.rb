class ViewingPartySerializer
    include JSONAPI::Serializer
    attributes :name, :start_time, :end_time, :movie_id, :movie_title

    attribute :invitees do |viewing_party|
        invitees = viewing_party.users_viewing_parties.where(host:false)
        users = invitees.map do |invitee|
            invitee.user
        end
        valid_users = users.compact
        valid_users.map do |user|
            {
                id: user.id,
                name: user.name,
                username: user.username
            }
        end
    end
end