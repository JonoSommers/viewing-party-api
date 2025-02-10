class UsersViewingParty < ApplicationRecord
    belongs_to :user
    belongs_to :viewing_party

    validates :viewing_party_id, presence: true
    validates :user_id, presence: true

    before_save :set_host_to_true, if: :host_not_set?

    def set_host_to_true
        self.update!(host: true)
    end

    def host_not_set?
        self.host.nil?
    end

    def self.add_new_invitee_to_party(user_id, party_id, id, invitee_id)
        User.find(user_id)
        viewing_party = ViewingParty.find(party_id)
        UsersViewingParty.find(id)
        already_invited = UsersViewingParty.find_by(user_id: invitee_id, viewing_party_id: viewing_party.id)
        if already_invited.nil?
            UsersViewingParty.create(user_id: invitee_id, viewing_party_id: viewing_party.id, host: false)
        end
    end
end