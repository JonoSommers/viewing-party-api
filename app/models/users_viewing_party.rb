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
end