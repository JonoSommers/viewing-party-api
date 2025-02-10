class Api::V1::UsersViewingPartiesController < ApplicationController
    def update
        UsersViewingParty.add_new_invitee_to_party(params[:user_id], params[:viewing_party_id], params[:id], params[:invitee_id])
        render json: ViewingPartySerializer.new(ViewingParty.find(params[:viewing_party_id]))
    end
end