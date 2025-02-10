class Api::V1::UsersViewingPartiesController < ApplicationController
    def update
        user = User.find(params[:id])
        viewing_party = ViewingParty.find(params[:id])
        UsersViewingParty.create(user_id: user.id, viewing_party_id: viewing_party.id, host: false)
        render json: ViewingPartySerializer.new(viewing_party)
    end
end