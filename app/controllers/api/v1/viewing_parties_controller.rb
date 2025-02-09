class Api::V1::ViewingPartiesController < ApplicationController

    def create
        user = User.find(params[:user_id])
        viewing_party = user.viewing_parties.create!(party_params)
        ViewingParty.compare_runtime_to_party_time(viewing_party)
        viewing_party.check_if_party_ends_before_starting(params[:start_time], params[:end_time])
        ViewingParty.add_invitees_to_joins_table(params[:invitees], viewing_party)
        render json: ViewingPartySerializer.new(viewing_party)
    end

    private

    def party_params
        params.require(:viewing_party).permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end
end